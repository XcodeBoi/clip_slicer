# Game clips *Faster*

## Usage

### Download [ffmpeg](https://ffmpeg.org/download.html) and [MPV](https://mpv.io/installation/)

Look for the windows binaries. Place the exe in a safe place on your computer that you will never move it from. For me this is `~/Desktop/Applications/ffmpeg`. Add it to your shell path with `notepad $profile` and then add `$env:Path += ";[path to the ffmpeg binary]"`.

### Install script

Go to your MPV install location. Make a new folder called `scripts` and place `slicing.lua` inside. 

### Configure

The script will automatically save videos to `~/Videos/Clips/`. You can adjust this on line `8` at the top of the lua script. The bitrate also autmatically targets a 7.5mb file size. This can be adjusted line `59`, where the default configuration is `60` (in megabits).

### Activate

Press `c` at any point in the video (take care not to do capital `C`) and press `c` again anywhere else. Note that the progam will not extract the clip if it reaches the end of the video before you press `c`.

After marking the video for the second time a cmd prompt window should open and automatically run `ffmpeg`. Leave it open until it finishes on its own, depending on the length of the clip it could take a long time.
