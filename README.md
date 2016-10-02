# BeebOPL
## An FM synthesiser for the BBC Microcomputer based on the YM3812

This is an FM Synthesiser Sound Card for the BBC Microcomputer. It is based on the YM3812 chip as used in the Ad Lib Sound Card and the original Soundblaster. 

It connects to the 1MHz Bus and is programmed by reference to two addresses in the BBC memory map. These are `YMADDR` (&FC04) and `YMDATA` (&FC04).

For some samples of what BeebOPL can do have a look at this [playlist on SoundCloud] (https://soundcloud.com/user-469563483/sets/beebopl-1)

The `DROPLAY` utility will play _DOSBox Raw OPL_ (DRO) version 2.0 files natively. These files can be generated by playing any OPL file in DOSBox (version 0.74). Visit http://www.dosbox.com for details.

The syntax for the compiled executable is `*DROPLAY <fsp>`. The code is compiled to load in the page above `PAGE`. It loads as much as it can of the DRO file from the page immediately above the program up to the page below `HIMEM`. If the entire file fits into memory, it is simply played from memory. Otherwise, further data is streamed from the disc using `OSGBPB` in the form of a circular buffer. 

All disc reads take place in the foreground. The music player itself is an interrupt driven background task. Interrupts are generated by the YM3812 timer. This avoids using the User VIA timer as this seems to interfere with certain solid state filing system.


**_Issues and to do_**

- [x] ~~System crashes following use of the `ESCAPE` key.~~

- [x] ~~Check for the presence of a BeebOPL card before attempting to play a file and issue error.~~

- [x] ~~Include error messages for card not found, not a valid DRO file, unsupported DRO version, wrong card version and compressed file not supported.~~ 

- [ ] The YM3812 flush routine doesn't seem to work all the time. Subsequent tunes can be a little corrupted if they are played without a preceding hard break.

- [ ] Due to an inherent problem with OSGBPB, the filing system cannot keep up with the demands of particularly large/complex DRO files. The player effectively '_laps_' the circular buffer and starts repeating the same segment of the file.

- [ ] Check if the entire DRO file will fit in memory and, if so, load it with `OSFILE` rather than `OSGBPB` to speed up loading times.

- [ ] Address continuing minor timing issues. DRO timing data is based on milliseconds. The YM3812 timer updates every 80 microseconds and therefore cannot measure precisely one millisecond. 

- [ ] check to see if player has overtaken buffer and issue error

- [ ] The registers are flushed too soon. Need to leave time for the last note to fade.

- [ ] Generally tidy up code; in particular using curly braces and local variables.

- [ ] Jukebox inexplicably occasionally reports "BeebOPL card not found"

Further down the line, I would like to see if the use of [Exomiser] (http://hem.bredband.net/magli143/exo/) could be incorporated.

I would also like to see if I could include **kieranhj**'s direct track loading routines using `OSWORD` (which he uses in his amazing [Mode 7 Video] (https://github.com/kieranhj/mode7-video) project). This may resolves the problems associated with `OSGBPB`.

It would also be useful if there could be some kind of (software) master volume control.

Finally, the utility provides no form of visual output. It would be nice to add something such as some Digital VU Meter Bars, or even just a progress counter.