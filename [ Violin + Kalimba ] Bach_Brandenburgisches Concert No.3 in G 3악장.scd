// 광운대학교 소프트웨어학부 2 학년 배주환
// Kwangwoon University Department of Computer Science and Engineering Sophomore Juhwan Bae
// ( 2023.06.22 )
// String, Kalimba -> BWV1048 3rd.Movt

(
SynthDef(\string, { |out=0, midinote = 60, amp = 0.1, dur = 1, len = 1|
		var	envelopeLevels = [0, 0.3, 0.3, 0];
	    var envelopeTimes = [0.1, dur * 2, dur * 0.5];
		var envelopeCurves = [ 2, 0, -1 ];
		var partialAmps = [
			-15.4, -16.5, -17.0, -36.2, -33.8, -33.4, -36.5, -21.9, -30.3, -38.1, -37.8, -43.2, -39.0, -34.0, -35.1, -43.6, -38.2, -40.2, -42.2, -48.8, -50.3, -49.0, -49.5, -50.4, -57.3, -53.9, -57.7, -58.8, -56.6, -62.3, -65.2, -64.9, -67.3, -67.3, -62.5, -68.3, -68.6, -71.4, -71.1, -79.3, -85.1, -80.2, -77.4, -75.2, -79.0, -85.3, -84.0, -83.7, -81.3, -79.4
		];
		var partialBaseFreqs = midinote.midicps;
		var envelope = Env(envelopeLevels, envelopeTimes, envelopeCurves);
		var envGen = EnvGen.ar(envelope, doneAction: Done.freeSelf);
		var numOvt = partialAmps.size;
		var partialFreqs = (partialBaseFreqs * (1..numOvt));
		//var sig = SinOsc.ar(partialFreqs, mul: partialAmps.dbamp).sum * envGen;
		var sig1 = WhiteNoise.ar;
		var sig2 = SinOsc.ar(partialFreqs, mul: partialAmps.dbamp).sum * envGen;
		var sig;
		sig1 = Resonz.ar(sig1, partialFreqs, 0.001, partialAmps.dbamp).sum * envGen * 200;
		sig = sig1 + sig2;
		sig = Pan2.ar(sig, 0);
		OffsetOut.ar(out, sig)
}).add
)

(
SynthDef(\kalimba, { |out=0, midinote = 60, amp = 0.1, dur = 1, len = 1|
		var	envelopeLevels = [ [0, 0.5, 0.15, 0], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ], [ 0, 0.2, 0 ] ];
	    var envelopeTimes = [ [ 0.002, 0.05, 2.6 ], [ 0.002, 0.45 ], [ 0.002, 0.07 ], [ 0.002, 0.07 ], [ 0.002, 0.07 ], [ 0.002, 0.07 ], [ 0.002, 0.07 ], [ 0.002, 0.07 ], [ 0.002, 0.07 ], [ 0.002, 0.07 ] ];
		var envelopeCurves = [ [ -1, -7, -5 ], [ -1, -5 ], [ -1, -10 ], [ -1, -10 ], [ -1, -10 ], [ -1, -10 ], [ -1, -10 ], [ -1, -10 ], [ -1, -10 ], [ -1, -10 ] ];
		var partialAmps = [ [ -27.0, -70.2, -63.7 ].dbamp, [ -41.5 ].dbamp, [ -54.5 ].dbamp, [ -57.9 ].dbamp, [ -60.8 ].dbamp, [ -59.3 ].dbamp, [ -55.5 ].dbamp, [ -66.1 ].dbamp, [ -73.0 ].dbamp, [ -72.8 ].dbamp ];
		var partialBaseFreqs = [ midinote.midicps, 1612, 4513, 5175, 5622, 6439, 8809, 9334, 11380, 13296 ];
	    var synth = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
	    var x;
	    var envelope, envGen, numOvt, partialFreqs;

	    envelope = Env(envelopeLevels[0], envelopeTimes[0], envelopeCurves[0]);
	    envGen = EnvGen.ar(envelope, doneAction: Done.freeSelf);
		numOvt = partialAmps[0].size;
		partialFreqs = (partialBaseFreqs[0] * (1..numOvt)).postln;

		synth[0] = SinOsc.ar(partialFreqs, 0, partialAmps[0] * envGen).sum * 10;

	    ( 1 .. 9 ).do{
			|i|
			envelope = Env(envelopeLevels[i], envelopeTimes[i], envelopeCurves[i]);
			envGen = EnvGen.ar(envelope);
			numOvt = partialAmps[i].size;
			partialFreqs = (partialBaseFreqs[i] * (1..numOvt)).postln;

			synth[i] = SinOsc.ar(partialFreqs, 0, partialAmps[i] * envGen).sum * 10
		};

	    x = synth[0] + synth[1] + synth[2] + synth[3] + synth[4] + synth[5] + synth[6] + synth[7] + synth[8] + synth[9];
		OffsetOut.ar(out, x)
}).add
)

//////////////////////////////////////////////////////////

(
~bwv1048_3 = [
    [ // bar 01
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[67], 64, 16],
            [[66], 64, 16],
			[[67, 71], 64, 16],
			[[69], 64, 16],
			[[71, 74], 64, 16],
			[[72], 64, 16],

			[[66, 74], 64, 16],
			[[76], 64, 16],
			[[69, 74], 64, 16],
			[[72], 64, 16],
			[[74, 71], 64, 16],
			[[69], 64, 16],

			[[67, 71], 64, 16],
			[[66], 64, 16],
			[[67, 71, 74], 64, 16],
			[[69], 64, 16],
			[[71, 74, 79], 64, 16],
			[[72], 64, 16],

			[[66, 74, 78], 64, 16],
			[[76, 79], 64, 16],
			[[69, 74, 78], 64, 16],
			[[72, 76], 64, 16],
			[[71, 74], 64, 16],
			[[69, 72], 64, 16]
        ]
    ],

	[ // bar 02
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[67, 71], 64, 16],
            [[66], 64, 16],
			[[67, 74], 64, 16],
			[[69], 64, 16],
			[[71, 79], 64, 16],
			[[72], 64, 16],

			[[74, 78], 64, 16],
			[[76, 79], 64, 16],
			[[74, 78], 64, 16],
			[[72, 76], 64, 16],
			[[69, 74], 64, 16],
			[[67, 72], 64, 16],

			[[55, 67, 71], 64, 16],
			[[54], 64, 16],
			[[55, 71, 74], 64, 16],
			[[57], 64, 16],
			[[59, 79], 64, 16],
			[[60], 64, 16],

			[[62, 69, 78], 64, 16],
			[[64, 79], 64, 16],
			[[62, 72, 78], 64, 16],
			[[60, 76], 64, 16],
			[[59, 62, 74], 64, 16],
			[[57, 72], 64, 16]
        ]
    ],

	[ // bar 03
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[55, 74, 83], 64, 16],
            [[54, 76, 84], 64, 16],
			[[55, 74, 79, 83], 64, 16],
			[[57, 72, 81], 64, 16],
			[[59, 71, 74, 79], 64, 16],
			[[55, 69, 78], 64, 16],

			[[60, 67, 76], 64, 16],
			[[62, 74, 78], 64, 16],
			[[60, 72, 76], 64, 16],
			[[59, 74, 78], 64, 16],
			[[57, 67, 73, 79], 64, 16],
			[[55, 71, 76], 64, 16],

			[[54, 69, 72, 81], 64, 16],
			[[52, 74, 83], 64, 16],
			[[54, 73, 78, 81], 64, 16],
			[[55, 71, 79], 64, 16],
			[[57, 69, 73, 78], 64, 16],
			[[54, 67, 76], 64, 16],

			[[59, 66, 74], 64, 16],
			[[61, 73, 76], 64, 16],
			[[59, 71, 74], 64, 16],
			[[57, 73, 76], 64, 16],
			[[55, 66, 71, 78], 64, 16],
			[[54, 69, 74], 64, 16]
        ]
    ],

	[ // bar 04
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[52, 67, 71, 79], 64, 16],
            [[50, 72, 81], 64, 16],
			[[52, 67, 71, 76, 79], 64, 16],
			[[54, 69, 78], 64, 16],
			[[55, 67, 71, 76], 64, 16],
			[[52, 66, 74], 64, 16],

			[[57, 64, 67, 73], 64, 16],
			[[59, 71], 64, 16],
			[[59, 69, 73, 76], 64, 16],
			[[55, 74], 64, 16],
			[[54, 67, 73, 76, 81], 64, 16],
			[[52, 73], 64, 16],

			[[50, 66, 74], 64, 16],
			[[64], 64, 16],
			[[62, 69, 78], 64, 16],
			[[64], 64, 16],
			[[66, 74, 81], 64, 16],
			[[67], 64, 16],

			[[45, 64, 67, 73], 64, 16],
			[[71], 64, 16],
			[[67, 69, 76], 64, 16],
			[[67], 64, 16],
			[[66, 73, 81], 64, 16],
			[[64], 64, 16]
        ]
    ],

	[ // bar 05
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[50, 62, 66, 74], 64, 16],
            [[61], 64, 16],
			[[62, 69, 78], 64, 16],
			[[64], 64, 16],
			[[66, 74, 81], 64, 16],
			[[67], 64, 16],

			[[45, 69, 72], 64, 16],
			[[71, 74], 64, 16],
			[[69, 72, 76], 64, 16],
			[[67, 71], 64, 16],
			[[66, 69, 81], 64, 16],
			[[64, 67], 64, 16],

			[[38, 50, 66, 74], 64, 16],
			[[73], 64, 16],
			[[42, 54, 69, 74], 64, 16],
			[[76], 64, 16],
			[[45, 57, 74, 78], 64, 16],
			[[79], 64, 16],

			[[33, 45, 73, 81], 64, 16],
			[[74, 83], 64, 16],
			[[40, 52, 73, 81], 64, 16],
			[[71, 79], 64, 16],
			[[45, 57, 69, 78], 64, 16],
			[[67, 76], 64, 16]
        ]
    ],

	[ // bar 06
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[50, 66, 74], 64, 16],
            [[49], 64, 16],
			[[50, 69, 78], 64, 16],
			[[52], 64, 16],
			[[54, 62, 69], 64, 16],
			[[55], 64, 16],

			[[57, 73, 76], 64, 16],
			[[59, 74], 64, 16],
			[[57, 73, 79], 64, 16],
			[[55, 71], 64, 16],
			[[54, 69], 64, 16],
			[[52, 67], 64, 16],

			[[50, 69, 78], 64, 16],
			[[49, 67], 64, 16],
			[[50, 66, 69, 74, 78], 64, 16],
			[[52, 64, 67], 64, 16],
			[[54, 62, 66, 69, 78], 64, 16],
			[[50, 61, 64], 64, 16],

			[[55, 59, 66, 78], 64, 16],
			[[57], 64, 16],
			[[55, 59, 66, 78], 64, 16],
			[[54, 61], 64, 16],
			[[52, 62, 66, 78], 64, 16],
			[[50, 59], 64, 16]
        ]
   ],

	[ // bar 07
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[49, 64, 68, 76], 64, 16],
            [[47, 66, 69], 64, 16],
			[[49, 64, 68, 73, 76], 64, 16],
			[[50, 62, 66], 64, 16],
			[[52, 61, 64, 68, 76], 64, 16],
			[[49, 59, 62], 64, 16],

			[[54, 57, 69, 76], 64, 16],
			[[56, 71], 64, 16],
			[[54, 57, 69, 76], 64, 16],
			[[52, 59, 68], 64, 16],
			[[50, 61, 66, 76], 64, 16],
			[[49, 57, 64], 64, 16],

			[[47, 62, 66, 74], 64, 16],
			[[45, 64, 68], 64, 16],
			[[47, 62, 66, 71], 64, 16],
			[[49, 61, 64], 64, 16],
			[[50, 59, 62, 68, 74], 64, 16],
			[[47, 57, 60], 64, 16],

			[[52, 56, 68, 74], 64, 16],
			[[54], 64, 16],
			[[52, 56, 71, 74], 64, 16],
			[[51, 57], 64, 16],
			[[49, 59, 64, 74], 64, 16],
			[[47, 56], 64, 16]
        ]
   ],

	[ // bar 08
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[45, 64, 69, 73], 64, 16],
            [[76], 64, 16],
			[[45, 64, 69, 73], 64, 16],
            [[76], 64, 16],
			[[45, 52, 61, 64, 69, 73], 64, 16],
            [[76], 64, 16],

			[[45, 66, 69, 74], 64, 16],
			[[78], 64, 16],
			[[45, 66, 69, 74], 64, 16],
			[[78], 64, 16],
			[[45, 54, 62, 66, 69, 74], 64, 16],
			[[78], 64, 16],

			[[45, 67, 73, 76], 64, 16],
			[[79], 64, 16],
			[[45, 67, 69, 76], 64, 16],
			[[79], 64, 16],
			[[45, 52, 61, 67, 73, 76], 64, 16],
			[[79], 64, 16],

			[[45, 69, 74, 78], 64, 16],
			[[81], 64, 16],
			[[45, 54, 62, 69, 74, 78], 64, 16],
			[[81], 64, 16],
			[[45, 54, 57, 69, 74, 78], 64, 16],
			[[81], 64, 16],
        ]
   ],

	[ // bar 09
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[45, 64, 73, 76, 79], 64, 16],
            [[67, 69], 64, 16],
			[[57, 61, 73, 76, 79], 64, 16],
            [[67, 69], 64, 16],
			[[57, 73, 76, 79], 64, 16],
            [[67, 69], 64, 16],

			[[45, 66, 74, 78, 81], 64, 16],
			[[69], 64, 16],
			[[57, 62, 74, 78, 81], 64, 16],
			[[69], 64, 16],
			[[57, 74, 78, 81], 64, 16],
			[[69], 64, 16],

			[[33, 45, 73, 76, 79, 85], 64, 16],
			[[67, 69], 64, 16],
			[[33, 45, 73, 76, 79, 85], 64, 16],
			[[67, 69], 64, 16],
			[[33, 45,  73, 76, 79, 85], 64, 16],
			[[67, 69], 64, 16],

			[[33, 45, 74, 78, 81, 86], 64, 16],
			[[69], 64, 16],
			[[33, 45,  74, 78, 81, 86], 64, 16],
			[[69], 64, 16],
			[[33, 45, 74, 78, 81, 86], 64, 16],
			[[69], 64, 16],
        ]
   ],

	[ // bar 10
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[33, 45, 64, 73], 64, 16],
            [[67], 64, 16],
			[[37, 49, 57, 69], 64, 16],
			[[67], 64, 16],
			[[40, 52, 64, 69], 64, 16],
			[[67], 64, 16],

			[[37, 49, 64, 69], 64, 16],
			[[67], 64, 16],
			[[40, 52, 57, 69], 64, 16],
			[[67], 64, 16],
			[[45, 57, 64, 69], 64, 16],
			[[67], 64, 16],

			[[38, 50, 78, 81, 84], 64, 16],
			[[74], 64, 16],
			[[42, 54, 78, 81, 84], 64, 16],
			[[74], 64, 16],
			[[45, 57, 78, 81, 84], 64, 16],
			[[74], 64, 16],

			[[42, 54, 78, 81, 84], 64, 16],
			[[74], 64, 16],
			[[45, 57, 78, 81, 84], 64, 16],
			[[74], 64, 16],
			[[50, 62, 78, 81, 84], 64, 16],
			[[74], 64, 16],
        ]
   ],

	[ // bar 11
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[31, 43, 79, 83], 64, 16],
            [[84], 64, 16],
			[[50, 59, 71, 86], 64, 16],
			[[84], 64, 16],
			[[50, 62, 74, 83], 64, 16],
			[[81], 64, 16],

			[[43, 50, 59, 71, 79], 64, 16],
			[[81], 64, 16],
			[[50, 55, 59, 62, 74, 83], 64, 16],
			[[81], 64, 16],
			[[50, 55, 59, 62, 79], 64, 16],
			[[78], 64, 16],

			[[43, 52, 57, 73, 76], 64, 16],
			[[78], 64, 16],
			[[43, 52, 57, 76, 79], 64, 16],
			[[78], 64, 16],
			[[43, 52, 57, 76, 81], 64, 16],
			[[74], 64, 16],

			[[43, 52, 57, 73, 76], 64, 16],
			[[74], 64, 16],
			[[43, 52, 57, 76, 81], 64, 16],
			[[74], 64, 16],
			[[43, 52, 57, 73, 85], 64, 16],
			[[71], 64, 16]
        ]
   ],

	[ // bar 12
       [ // voice 1, 2, 3: all voices have the same rhythms.
			// entry: [aChord, velocity, length.reciprocal]
            [[42, 54, 69, 74], 64, 16],
            [[71], 64, 16],
			[[40, 52, 66, 69, 74], 64, 16],
			[[67, 76], 64, 16],
			[[38, 50, 66, 78], 64, 16],
			[[67], 64, 16],

			[[45, 57, 64, 69], 64, 16],
			[[66], 64, 16],
			[[64, 67, 74], 64, 16],
			[[69], 64, 16],
			[[33, 45, 64, 67, 71, 73], 64, 16],
			[[73], 64, 16],

			[[26, 38, 66, 74], 64, 16],
			[[71], 64, 16],
			[[69], 64, 16],
			[[67], 64, 16],
			[[66], 64, 16],
			[[64], 64, 16],

			[[62], 64, 16 / 6]
        ]
   ]
];
)

//////////////////////////////////////////////////////////

(
~player = {
    |music, synth, tempo=60, nthBar=0, vol=1|
    var timeFactor, entries, voiceItems, maxItemVoice, lastVoice, buffer_limit = 0;
    timeFactor = 60 / tempo * 4;
    entries = music[nthBar];
    voiceItems = entries.size.collect { |nth|
        entries[nth].size.collect { |ith|
            entries[nth][ith][2].reciprocal
        }
    };
    maxItemVoice = voiceItems.size.collect {
        |nth|
        var items, range;
        items = voiceItems[nth];
        range = (0 .. items.size - 2);
        (items.size == 1).if{ 0 }{ items[range].sum }
    };

    lastVoice = maxItemVoice.maxIndex;

    ("Bar" + nthBar ++ "\nThe voice which will be played lastly:" + lastVoice).postln;

    {
        |vce|

        fork {

            (
                "\t\tVoice" + vce + "numItems:" + entries[vce].size +
                "\n\t\t\t\t\t\t  "++ entries[vce]
            ).postln;

            entries[vce].do {
                |entry, idxEntry|
                var aChord, entryPlayer, len, untilNext, rAmp, rRls;

                aChord = entry[0].asArray;
                entryPlayer = Array.newClear(10);
                len = entry[2];
                untilNext = len.reciprocal;
                rAmp = -1.5.rand.dbamp;
                rRls = rrand(0.01, 0.03);
                aChord.size.do { |i|
                    var aNote, amp;
                    aNote = aChord[i];
                    amp = entry[1] / 127 * (2.pow(-3 - (i - 1.0.rand) + rAmp));
                    (
                        instrument: synth,
                        midinote: aNote, amp: amp * vol,
                        dur: untilNext, len:1
                    ).play;
                    (
                        [
                            "voice:" + vce,
                            "MIDI note:" + aNote,
                            "rhythm:" + untilNext.asString.padRight(8, "0"),
                            "db FS:" + amp.ampdb.round(0.01).asString.padRight(6, "0") + "dB"
                        ]
                    ).postln;
                };

                ( timeFactor * untilNext /*+ (128.reciprocal.rand2)*/ - rRls).wait;
                /*                aChord.size.do {
                |i|
                s.bind { entryPlayer[i].release }
                };
                */

                rRls.wait;

                if (
                    (nthBar != (music.size - 1))
                    &&
                    vce == lastVoice
                    &&
                    (idxEntry == (entries[vce].size - 1))
                )
                {
                    nthBar = nthBar + 1;
                    ~player.(music, synth, tempo, nthBar, vol);
                }
            }
        };
    } ! entries.size;
}
)

/////////////////////////////////////////////////////////

(
s.serverRunning.not.if { s.boot } { "Server is already booted." };
~player.((~bwv1048_3 ! 2).flatten(1), \string, 110, 0, 1);
)

(
s.serverRunning.not.if { s.boot } { "Server is already booted." };
~player.((~bwv1048_3 ! 2).flatten(1), \kalimba, 110, 0, 1);
)

(
s.serverRunning.not.if { s.boot } { "Server is already booted." };
~player.((~bwv1048_3 ! 2).flatten(1), \string, 110, 0, 1);
~player.((~bwv1048_3 ! 2).flatten(1), \kalimba, 110, 0, 1);
)

// -> 둘을 합치면 칼림바가 살짝 더 빨리 ( 약 16분음표의 길이 ) 끝나는 것 같음.


s.plotTree
s.meter