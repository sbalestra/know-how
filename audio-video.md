# Remove Audio stream from video

    avconv -i input.avi -an -c:v copy output.avi

(Source: http://ubuntuforums.org/showthread.php?t=2084457&s=f0e0024253bf6293f84a00c1eaa54a44&p=12356277#post12356277 , http://www.commandlinefu.com/commands/view/10992/remove-audio-stream-from-a-media-file)

    ffmpeg -i [input_file] -vcodec copy -an [output_file]

(Source: http://superuser.com/a/484860 )

# Crop away beginning and end from video

Source: https://superuser.com/questions/377343/cut-part-from-video-file-from-start-position-to-end-position-with-ffmpeg , http://www.dototot.com/how-to-trim-videos-with-the-command-line-using-avconv/

## Accurate method

    avconv -i input.avi -ss 00:00:42 -t 00:03:26 -codec copy output.avi 

Parameters:

- `-ss`: Start time
- `-t`: Duration

# Convert to h264/.mp4

    avconv -i input.avi -c:v libx264 output.mp4

Source: http://stackoverflow.com/a/18979552

# Prepare for upload to Mapillary (remove audio, convert videoformat)

    avconv -i input.avi -an -c:v libx264 output.mp4

# Change container format

see https://superuser.com/questions/378726/convert-from-mov-to-mp4-container-format
