/**
 * 
 * File:		Circle_Defense.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * Main project file that sets the SWF properties and just creates a Simulator.
 * 
 **/
package circledefense
{
	import flash.display.Sprite;
	
	//Set screen size, color, and framerate
	[SWF(width='700',height='900',backgroundColor='#070707',frameRate='55')]
	
	public class Circle_Defense extends Sprite
	{
		/**CONSTRUCTOR**/
		public function Circle_Defense()
		{
			//Create Simulator
			var sim: Simulator = new Simulator(this);			
		}
	}
}