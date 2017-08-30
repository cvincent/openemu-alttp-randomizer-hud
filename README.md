# ALttP Randomizer auto-updating HUD for OpenEmu/Mac

It does what it says it does.

## Requirements

* I'm running the HUD in latest Chrome, but the latest version of your favorite browser should work fine.
* I developed the script in Ruby 2.4.1, but it should work with your default system Ruby version.
* The script assumes you're using the SNES9X core in OpenEmu. It will not work with other SNES cores.
* When generating your randomized ROM, you **must** turn the `SRAM Trace` option **on**.

## Installation and usage

After downloading, here's how to run it:

* Terminal.app will need access to accessibility controls. Go to:
  `System Preferences > Security & Privacy > Privacy tab > Accessibility`. Click the lock and enter your password to make changes. Click the `+` button and add Terminal, which can be found in `/Applications/Utilities/Terminal`.
* Open your game in OpenEmu, then open the `hud.html` file (I've only tested this in latest Chrome, but it probably works in your browser of choice).
* Last, in Terminal, `cd` into the HUD directory and get the script running. The following command will update the HUD every 10 seconds (**note the trailing slash** in the save state path, it's important!):
`ruby update_hud.rb 10 ~/Library/Application\ Support/OpenEmu/Save\ States/YOUR_ROM_NAME_HERE/`

## Alternative mode: manual saves

The default usage above works by forcing OpenEmu to come to the foreground and Quick Save every X seconds. This might be not be ideal for some setups (see caveats below). The alternative mode just watches for your Quick Save to change rather than forcing Quick Saves at a regular interval.

With this mode, you can set a handy keyboard shortcut or an extra button on your gamepad in OpenEmu preferences to perform Quick Saves easily. After you get a new item, when convenient, do the Quick Save to update your HUD. This approach ensures you're not getting unexpected frame rate lag during critical parts of your run due to automatic Quick Saves. It's not quite as handy as a fully automated system (which I'd like to make happen, see caveats below), but it's better than having to stop mid-game to mouse around and update the HUD totally manually.

This mode works exactly the same as above, with the following exceptions:

* You'll need to install the `listen` gem. This Terminal command should do it: `gem install listen`
* Instead of the number of seconds between updates, pass the `--listen` option, like so:
`ruby update_hud.rb --listen ~/Library/Application\ Support/OpenEmu/Save\ States/YOUR_ROM_NAME_HERE/`

One thing to note, because the SRAM Trace feature of the randomizer is on its own timer (as noted in the caveats below), it's possible that your first save won't show any changes on the HUD. If this happens, do another Quick Save in a few seconds and the update should take.

## Caveats/future improvements

* The main weakness in this script is that I don't know of a better way to read the current SRAM state other than forcing OpenEmu to dump it to the filesystem via Quick Save. While the game is saving its state, you may get some mild frame rate dropping, and OpenEmu's floppy disk icon will appear each time. I would love a better approach to this, so please contact me if you have better ideas.
* The only way I could force OpenEmu to Quick Save was via AppleScript, and as far as I know there's no way to do it without forcing OpenEmu to the foreground each time, which might be annoying depending on your setup if you're streaming to Twitch. Again, this could be avoided if I knew of an easier way to access the game's current SRAM state.
* Depending on your update frequency, you may see a delay in your HUD being updated. This is due to the ROM's SRAM Trace functionality being on its own timer.
* ~~Currently tracks all the major inventory items. With a little more work, it could also track pendants, crystals, and Agahnim.~~
* Doesn't have fancy options for customizing the UI. But if you're good with HTML and CSS, it shouldn't be too hard to do that way.

## Pull requests

Yes, please!

