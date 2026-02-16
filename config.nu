# config.nu
#
# Installed by:
# version = "0.106.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

def jjp [] {
   jj bookmark move --from "heads(::@- & bookmarks())" --to @-; jj git push
}

def aws-log [job_id, region] {
   aws batch describe-jobs --jobs $job_id --region $region | from json | get jobs.container.logStreamName.0 | aws logs --region $region get-log-events --log-group-name /aws/batch/job --log-stream-name $in | from json | get events | update timestamp {|row| $row.timestamp | $in * 1000000 | into datetime }
}


# let carapace_completer = {|spans|
#    carapace $spans.0 nushell ...$spans | 从 json
#}
# $env.config = {
#    completions: {
#        external: {
#            enable: true
#            completer: $carapace_completer
#        }
#    }
#}

source $"($nu.cache-dir)/carapace.nu"


mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

$env.config.history = {
  isolation: true
  file_format : "sqlite"
}

$env.config = {
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
      if 'ENV_CONVERSIONS' in $env and 'PATH' in $env.ENV_CONVERSIONS {
        $env.PATH = do $env.ENV_CONVERSIONS.PATH.from_string $env.PATH
      }
    }]
  }
}


# https://github.com/nushell/nushell/issues/10610#issuecomment-2427673358
# def run-cmd-array [...cmd_arr: list] {
#     run-external ($cmd_arr | first) ...($cmd_arr | skip 1)
# }
# def psub [cmd: list, ...sub_cmds: closure] {
#     let tmpdir = (mktemp -d)
#     let index = ($sub_cmds | enumerate | select index)
#     let out_paths = (
#         $index.index | each {|i| [$tmpdir $i] | path join | wrap out_path }
#     )
#     let sub_cmds_table = (
#         $sub_cmds | wrap cmd | merge $index | merge $out_paths
#     )
#     for it in $sub_cmds_table {
#         do $it.cmd | save $it.out_path
#     }
#     run-cmd-array ...$cmd ...$sub_cmds_table.out_path
#     ^rm -fr $tmpdir | ignore
# }


def run-cmd-array [...cmd_arr: list] {
   run-external ($cmd_arr | first) ...($cmd_arr | skip 1)
}

def psub [cmd: list, ...sub_cmds: closure] {
   let tmpdir = (mktemp -d)
   let sub_cmds_with_index = (
         $sub_cmds | enumerate | each {|it|
            {
               cmd: $it.item
               index: $it.index
               out_path: ([$tmpdir ($it.index | into string)] | path join)
            }
         }
   )

   for it in $sub_cmds_with_index {
         do $it.cmd | save $it.out_path
   }

   run-cmd-array ...$cmd ...($sub_cmds_with_index.out_path)
   ^rm -fr $tmpdir | ignore
}
