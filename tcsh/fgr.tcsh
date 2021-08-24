# Why have separate script instead of just defining in ~/.cshrc ?
# Well, tcsh doesn't have function, and alias gets ugly really fast.
# Use this solution instead <https://stackoverflow.com/a/27807461/11548113>

# Usage: fgr [/some/folder/] <filename>

if ($#argv == 2) then
    find $argv[1] | grep -i $argv[2]
else
    find | grep -i $argv[1]
endif
