# vim: ft=ps1

# Note: 'gc' shadows Get-Content alias; use Get-Content by full name if needed
#       'gs' shadows Get-Service alias; use Get-Service by full name if needed
#       'gl' shadows Get-Location alias; explicitly removed below
Remove-Item Alias:gl -Force -ErrorAction SilentlyContinue

function g     { git $args }
function ga    { git add $args }
function gb    { git branch $args }
function gba   { git branch --all }
function gbd   { git branch -d $args }
function gbD   { git branch -D $args }
function gcp   { git cherry-pick $args }
function gre   { git restore $args }
function grs   { git restore --staged $args }
function grea  { git restore . }
function gpr   { git remote prune origin }
function gc    { git commit -m $args }
function gca   { git commit --amend $args }
function gcan  { git commit --amend --no-edit }
function gco   { git checkout $args }
function gsw   { git switch $args }
function gsc   { git switch -c $args }
function gcm   { git checkout master }
function gd    { git diff -w $args }
function gds   { git diff -w --staged }
function gs    { git status -sb }
function gcl   { git clone $args }
function gst   { git stash $args }
function gstp  { git stash push $args }
function gstpo { git stash pop }
function gpull { git pull $args }
function gpush { git push $args }
function gl    { git lg }
function grc   { git rebase --continue }
function gra   { git rebase --abort }
function gu    { git reset --soft HEAD~1 }

function git-current-branch {
    git branch | Select-String '^\*' | ForEach-Object { ($_ -replace '^\* ', '').Trim() }
}

function gup {
    $branch = git-current-branch
    git branch --set-upstream-to="origin/$branch" $branch
}

function ff { gpr; git pull --ff-only }
