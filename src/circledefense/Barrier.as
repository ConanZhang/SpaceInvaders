/**
 * 
 * File:		Barrier.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * Barrier class that will create a Sprite Barrier that can collide and be set at initial offset and rotation.
 * 
 **/
package circledefense
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class Barrier extends Sprite implements Mover, Collider
	{		
		/**Class Member Variables**/
		//Location
		protected var xCoordinate   : Number;
		protected var yCoordinate   : Number;
		
		protected var startingXCoordinate: Number;//intial position that will change when game starts (moves left and right)
		
		//Rotation
		protected var initialRotation: Number;//starting angle of rotation
		protected var speedOfRotation: Number;//rotates speedOfRotation degrees CLOCKWISE
		
		//Graphical properties
		protected var barrierLength  : Number;//size
		protected var barrierColor   : Number;//color
		
		//Movement
		protected var isMovingLeft   : Boolean = ( Math.random() > 0.5);//Randomize initial direction
		protected var isMovingRight  : Boolean = !isMovingLeft;
		
		protected var barrierSpeed	 : Number = 1;//speed by pixels left or right
		
		/**CONSTRUCTOR**/
		public function Barrier(owner                   : DisplayObjectContainer,	
								xCoordinateParameter   	: Number,
								yCoordinateParameter 	: Number,
								initialRotationParameter: Number,
								speedOfRotationParameter: Number,
								barrierLengthParameter  : Number,
								barrierColorParameter   : uint)
		{
			/**Assigning Class Member Variables to Parameters**/
			//Location
			xCoordinate     = xCoordinateParameter;
			yCoordinate		= yCoordinateParameter;
			
			//Rotation
			initialRotation = initialRotationParameter;
			speedOfRotation = speedOfRotationParameter;
			
			//Graphical Properties
			barrierLength   = barrierLengthParameter;
			barrierColor    = barrierColorParameter;
			
			
			/**Drawing and Stage Properties**/
			//Draw
			create_display_list();
			
			//Location
			this.x = xCoordinate;
			this.y = yCoordinate;
			
			startingXCoordinate = xCoordinate;//INITIAL STARTING X-COORDINATE
			
			this.rotation = initialRotation;//INITIAL STARTING ANGLE
			
			//Add to simulator
			owner.addChild(this);
			
		}
		
		/**MOVE FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function move():void
		{
			this.rotation += speedOfRotation;//rotate sprite by speedOfRotation degrees CLOCKWISE
			
			//Move Right or Left
			if(isMovingLeft)
			{
				this.x -= barrierSpeed;//move left
				
				//limit movement range from startingXCoordinate
				if(this.x == (startingXCoordinate - 15))
				{
					//switch directions
					isMovingRight = true;
					isMovingLeft = false;
				}
				
			}
			else if(isMovingRight)
			{
				this.x += barrierSpeed;//move right
				
				//limit movement range from startingXCoordinate
				if(this.x == (startingXCoordinate + 15) )
				{
					//switch directions
					isMovingRight = false;
					isMovingLeft = true;
				}
				
			}
		}
		
		/**DRAW FUNCTION**/
		public function create_display_list():void
		{
			//Set up
			this.graphics.clear();
			this.graphics.lineStyle(0.5, barrierColor);
			
			//Draw
			this.graphics.drawRect(-barrierLength/2, -5, barrierLength, 10);
		}
		
		/**COLLIDE FUNCTION FOR IMPLEMENTED INTERFACE COLLIDER**/
		public function collide(otherObject: Sprite):Boolean
		{
			/**TEST CODE**/
			//trace(this.hitTestObject(otherObject));
			
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
			return this.x;
		}
		
		/**getY FUNCTION FOR IMPLEMENTED INTERFACE MOVER**/
		public function getY():int
		{
			return this.y;
		}
		
	}//end class
}//end package