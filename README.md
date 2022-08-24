# Game clips *Faster*

## Install process

### 0. Download [ffmpeg](https://ffmpeg.org/download.html)

Look for the windows binaries. Place the exe in a safe place on your computer that you will never move it from. For me this is `~/Desktop/Applications/ffmpeg`. Add it to your shell path with `notepad $profile` and then add `$env:Path += ";[path to the ffmpeg binary]"`.

### 1. Download [MPV](https://mpv.io/installation/)

Look the windows binaries, should be at the top of the list. It'll link to sourceforge and you can hit "Download latest version".

### 2. Put MPV in a safe place

The whole unzipped MPV folder should be included in placed whereever you keep your portable programs. I keep mine at `~/Desktop/Applications/MPV`.

### 3. Update settings to use MPV

Navigate to settings > something something > something something. Make the MPV exe the default to open video files.

### 4. Install the script

Go to your MPV install location. Make a new folder called `scripts` and place `slicing.lua` inside. 

### 5. Configure the script

The script will automatically save videos to `~/Videos/Clips/`. You can adjust this on line `8` at the top of the lua script. The bitrate also autmatically targets a 7.5mb file size. This can be adjusted line `59`, where the default configuration is `60`. This value should be however many megabytes the file should be multiplied by 8.

### 6. Use the script

Double click any video and it should open in MPV. Press `c` at any point in the video (take care not to do capital `C`) and press `c` again anywhere else. Note that the progam will not extract the clip if it reaches the end of the video before you press `c`.

After marking the video for the second time a cmd prompt window should open and automatically run `ffmpeg`. Leave it open until it finishes on its own, depending on the length of the clip it could take longer.
