# nodenv
export-env { 
    load-env {
        PATH: ($env.PATH | split row (char esep) | prepend [$"($env.HOME)/.nodenv/bin" $"($env.HOME)/.nodenv/shims"])
        NODENV_VERSION: ""
        NODENV_VERSION_OLD: ""
        NODENV_SHELL: "nu"
    }
}

export def-env nodenv [
	command?: string@'nu-complete nodenv',
	...args
] {
    let new_env = if $command in ["rehash", "shell"] {
        # implement each on indiviudaly e.g.
        if $command == "shell" {
            { NODENV_VERSION_OLD: $env.NODENV_VERSION NODENV_VERSION: $args.0 }
        } else {
            error make { msg: $"`($command)` command is not supported yet" }
        }
    } else {
    	if ($command | is-empty) {
    		^nodenv
    	} else {
        	^nodenv $command $args
    	}
        {}
    }
    load-env $new_env
}

def 'nu-complete nodenv' [] {
    ^nodenv help
    | lines
    | where ($it | str starts-with "   ")
    | each {|entry| $entry | split row ' ' | get 0 }
}
