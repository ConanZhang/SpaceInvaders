/**
 * 
 * File:		Target.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The target is a Sprite that the Player is trying to shoot with a Ball, and then it will react.
 * 
 **/
package circledefense
{
	import flash.display.Sprite;
	
	public class Target extends Sprite implements Mover, Collider
	{
		/**Class Member Variables**/
		//Drawing
		private var drawing: TargetDrawing;//asset from circleDefenseFLA
		
		//Rotation
		private var speedOfRotation: Number = 0.5;//number of degrees rotated CLOCKWISE per frame
		
		//Movement
		protected var isMovingLeft: Boolean = true;//initially moves left
		protected var isMovingRight: Boolean = false;
		
		private var targetSpeed: int = 3;//pixels moved per frame

		/**CONSTRUCTOR**/
		public function Target(owner: Sprite)
		{
			//Create new drawing
			drawing = new TargetDrawing();//asset from circleDefenseFLA
			
			//Size
			drawing.scaleX = 0.20;
			drawing.scaleY = 0.20;
			
			//Position
			drawing.x = 0;
			drawing.y = -320;
			
			//Add drawing to PLAYER CLASS, PLEASE NEVER FORGET TO DO THIS!!!
			this.addChild(drawing);
			
			//Add to owner (simulator)
			owner.addChild(this);
		}
		
		/**MOVE FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function move():void
		{
			//Rotate
			drawing.rotation += speedOfRotation;
			
			//Movement
			if(isMovingLeft)
			{
				drawing.x -= targetSpeed;//move left
				
				if(drawing.x == -255)
				{
					//switch directions at limit
					isMovingRight = true;//move right
					isMovingLeft = false;//do not move left
				}
				
			}
			else if(isMovingRight)
			{
				drawing.x += targetSpeed;//move right

				if(drawing.x == 255)
				{
					//switch directions at limit
					isMovingRight = false;//do not move right
					isMovingLeft = true;//move left
				}
				
			}
		}
		
		/**COLLIDE FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function collide(otherObject: Sprite):Boolean
		{
			return (this.hitTestObject(otherObject));
		}
		
		/**GET NORMAL FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function getNormal():GeometricVector
		{
			return new GeometricVector(-1,0);
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
	}
}