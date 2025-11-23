a screensaver for nvim

![](https://github.com/haolian9/zongzi/assets/6236829/f8a61a08-3d67-4a40-9ee8-e1cde83105c7)

## status
* just works
* not configurable yet

## prerequisites
* nvim 0.11.*
* haolian9/infra.nvim

## usage

my personal config
```
do --blood moon
  local spell = cmds.Spell("BloodMoon", function(args) assert(require("bloodmoon")[args.op])() end)
  spell:add_arg("op", "string", false, "show", cmds.ArgComp.constant({ "enable", "disable", "show" }))
  cmds.cast(spell)
end
```

## todo
* dynamic scene? `tmux clock-mode`
