# In-progress features

Some features are still being worked on and need a bit of explanation in their current state.

Please direct any questions, suggestions or problems to the Xit project issues page: https://github.com/Uncommon/Xit/issues

## Accounts

In the Accounts preference pane, only TeamCity is actually implemented. Once you have logged in, build status indicators will appear in the repository window sidebar. The indicator is green if the latest builds for all configurations using that branch have passed, red if any have failed, and an empty circle if no builds are available.

Indicators are shown for local branches that have been pushed, and again for the corresponding remote branches. The option to show status for all remote branches - not just the ones that your local repository is tracking - may be added in the future.

Branches are looked up by the suffix after the last slash, which seems to be the way TeamCity works. I may need to adjust this as I learn more about TeamCity. (see issue #189)

## Push and Pull

The push and pull commands currently only push or pull the current branch. Expanded options for those commands will be added in the future.
