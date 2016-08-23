/**
 * 
 * File:		Ball.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Ball class contains code to draw the ball, reset it after a goal, move it, bounce it off an object, and set its coordinates.
 *
 * It is a Sprite and can move.
 *  
 **/
package circledefense
{
	import flash.display.Sprite;
	
	public class Ball extends Sprite implements Mover
	{
		/**Class Member Variables**/
		private var drawing: BallDrawing;//asset from circleDefenseFLA
		private var ballSpeed: Number = 15;//pixels to move by
		
		/**CONSTRUCTOR**/
		public function Ball(owner:Sprite)
		{
			//Create
			drawing = new BallDrawing();
			
			//Size
			drawing.scaleX = 0.25;
			drawing.scaleY = 0.25;
			
			//Position
			//X POSITION BASED ON PLAYER X POSITION
			drawing.y = 375;
			
			//Add drawing TO CLASS, PLEASE NEVER FORGET TO DO THIS!!!
			this.addChild(drawing);
			
			//Add class to stage
			owner.addChild(this);
		}
		
		/**MOVE FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function move():void
		{
			drawing.y -= ballSpeed;//the ball can only move vertically by ball speed
		}
		
		/**getX FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getX():int
		{
			return drawing.x;
		}
		
		/**getY FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getY():int
		{
			return drawing.y;
		}
		
		/**setX function to set x coordinate equal to player x coordinate**/
		public function setX(setXP:int):void
		{
			drawing.x = setXP;
			
		}
	}
}