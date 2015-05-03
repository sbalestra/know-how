# Remove Audio stream from video

    avconv -i input.avi -an -c:v copy output.avi

(Source: http://ubuntuforums.org/showthread.php?t=2084457&s=f0e0024253bf6293f84a00c1eaa54a44&p=12356277#post12356277 , http://www.commandlinefu.com/commands/view/10992/remove-audio-stream-from-a-media-file)

    ffmpeg -i [input_file] -vcodec copy -an [output_file]

(Source: http://superuser.com/a/484860 )
