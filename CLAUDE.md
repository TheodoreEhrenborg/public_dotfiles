# Commit convention

Whenever you commit, start the commit message with "Claude: ". And put "Co-Authored-By: Claude <noreply@anthropic.com>" in the details. Make sure the "Claude: " + rest of summary is at most 50 characters

# pingme

The `pingme` tool allows you to send me a short message, like
```
pingme "<topic> done"
```


# Remote Debug Loop for a vast machine
In this case vast06

## Local: Commit and Push
```bash
jj show --git # shows changes
jj commit -m "Description"
jj bookmark move --from "exactly(heads(::@- & bookmarks()), 1)" --to @- && jj git push
```

## Remote: Sync and Run
Unless I've told you otherwise or you're debugging a fast error, 
use the more complicated long-running job setup in the next section.

```bash
ssh vast06 "cd probabilistic-sae-private && gh repo sync -b branch-name && git checkout branch-name"
ssh vast06 "cd probabilistic-sae-private && time /root/.local/bin/uv run <command>"
```
Use `run_in_background`, not `&`

When running a background job, avoid tail -f because it may spew tokens. 
Avoid command substitution like `ssh vast19 "echo $(date)"` because it'll trigger a permission check even if I've given you ssh permissions
(since the substituted command is running on the local machine). 
If you must use command substitution, use single quotes (`ssh vast19 'echo $(date)'`) so it runs on the server

If you want to check in on a background job every 10 min using a 2nd sleep job, you should run the sleep job as a background job too. That way you'll get notified if the original job crashes/finishes or (at the latest) when the sleep job is done.

## Long-running jobs

                                                                                                                               
For jobs that will outlive your SSH connection:
                                                                                                                               
1. Start in tmux with logging:
```
ssh vast06 'cd probabilistic-sae-private && mkdir -p eval_results && tmux new-session -d -s job-name "time /root/.local/bin/uv run <command> 2>&1 | tee eval_results/job-name.log"'
```
                                                                                                                               
2. Check for zombie processes before monitoring:
```
ssh vast06 'ps aux | grep uv'
```
If you see multiple uv jobs launched at different times, that's a sign of zombie jobs - tell me.
                                                                                                                               
3. Set up completion monitoring. Don't use pgrep to find PID automatically:
```
ssh vast06 'tail --pid <PID> -f /dev/null'
```
with run_in_background=true. You'll be notified when the process completes.
                                                                                                                               
4. View logs:
```
ssh vast06 "tail -n 100 probabilistic-sae-private/eval_results/job-name.log"
```

## How to stop a vast instance

Run `uvx vastai show instances | grep theo`. In the short name `vast21`, the last 2 digits are the last 2 digits of the vast ID. So if you see output like
```
30119521  37586    running   1x  H200_NVL   0.0      32.0   2063.8  256      ssh2.vast.ai  39520     2.3431  theodoreehrenborg/ubuntu-uv      7032.2  8516.8    99.5  -      8387.27     -
```
and you want to stop vast21, run `uvx vastai stop instance 30119521`

If there's a zombie process on the GPU (check with nvidia-smi), you can fix that with                                                   
```
uvx vastai stop instance <8 digit id>
# wait 2 min
uvx vastai start instance <8 digit id>
```

# Writing NixOS systemd services
Don't forget to put grep and coreutils in the path. And start the script with set -e

```  
Environment = "PATH=${pkgs.gnugrep}/bin:${pkgs.coreutils}/bin:...
```  
