/*
 * The MIT License
 *
 * Copyright (c) 2008 Raffaele Sena <raff367@gmail.com>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import util.*;

class Main
{
	private var parent:MovieClip;
	
	function Main(mc:MovieClip)
	{
		// save reference to main movieclip
		this.parent = mc;
		
		UI.mainScreen(mc, UI.BLACK, "", 18);
		
		var sound_snd:Sound = new Sound();
		
		with (sound_snd) {
			attachSound("soundID");
			setVolume(100);
		}
		
		var button = mc.attachMovie("buttonID", "button_mc", mc.getNextHighestDepth(), {_x:(Stage.width/2)-40, _y:(Stage.height/2)-40 } );
		button.onPress = function() {
			sound_snd.stop();
			sound_snd.start();
			this._x += 1;
			this._y += 1;
		}
		button.onRelease = function() {
			this._x -= 1;
			this._y -= 1;
		}
	}
   
	static function main(mc:MovieClip)
	{
		var app = new Main(mc);
	}
}
