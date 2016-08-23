/**
 * 
 * File:		Scoreboard.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The scoreboard is a Sprite that keeps track of how many shots the player has taken.
 * 
 **/
package circledefense
{
	import flash.display.Sprite;
	import flash.display.DisplayObjectContainer;
	
	public class Scoreboard extends Sprite
	{
		/**Class Member Variables**/
		//Logic
		private var leftScore:  int = 0;//10's place
		private var rightScore: int = 0;//1's place
		
		//GUI
		private var leftDigit:DigitShadow;//10's place
		private var rightDigit:DigitShadow;//1's place
		
		/**CONSTRUCTOR**/
		public function Scoreboard(owner: DisplayObjectContainer)
		{
			/**10's Place Digit**/
			//Create 
			leftDigit = new DigitShadow(owner, -10, -425, 0, 0x101010, 0x00EE00, 0x00CC00);
			
			//Size
			leftDigit.scaleX = 0.1;
			leftDigit.scaleY = 0.1;
			
			/**1's Place Digit**/
			//Create 
			rightDigit = new DigitShadow(owner, 10, -425, 0, 0x101010, 0x00EE00, 0x00CC00);
			
			//Size
			rightDigit.scaleX = 0.1;
			rightDigit.scaleY = 0.1;
		}
		
		/**FUNCTION TO UPDATE SCORE EVERY FRAME**/
		public function updateScore(scoreParameter: int) : void
		{
			//ONE DIGIT SCORE
			if (scoreParameter<10)
			{
				//10's place is a 0
				leftDigit.createDisplayList(0);
				
				//Size 10's place
				leftDigit.scaleX = 0.1;
				leftDigit.scaleY = 0.1;	
				
				//1's place draws score from parameter
				rightDigit.createDisplayList(scoreParameter);
				
				//Size 1's place
				rightDigit.scaleX = 0.1;
				rightDigit.scaleY = 0.1;
			}			
			//TWO DIGIT SCORE
			else if (scoreParameter<=99)
			{
				//Draw 10's place digit divided by 10 (provides digit as one digit to draw)
				leftDigit.createDisplayList(scoreParameter/10);
				
				//Size 10's place
				leftDigit.scaleX = 0.1;
				leftDigit.scaleY = 0.1;	
				
				//Draw 1's place digit modulo by 10 (provides remainder as one digit to draw)
				rightDigit.createDisplayList(scoreParameter%10);
				
				//Size 1's place
				rightDigit.scaleX = 0.1;
				rightDigit.scaleY = 0.1;
			}

		}
	}
}