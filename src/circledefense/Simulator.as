/**
 * 
 * File:		Simulator.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * The Simulator is the "game engine" for all that is happening, as well as being used to 
 * place all of the other Sprites onto this Sprite.
 * 
 * NOTE: IT IS CENTERED AT 0,0
 * 
 **/
package circledefense
{
	import flash.display.*;
	import flash.events.*;
	import flash.media.SoundChannel;
	import flash.ui.Keyboard;
	
	
	public class Simulator extends Sprite
	{
		/**Class Member Variables**/
		//Vector arrays of interfaces
		private var movers: Vector.<Mover>;//holds all objects that move
		private var colliders: Vector.<Collider>;//holds all objects that collide
		private var shooters: Vector.<Shooter>;//holds all objects that shoot
		
		//Graphical display
		private var startStopButton: Button;//button to play/pause the game
		private var scoreboard: Scoreboard;//score to count number of shots fired
		
		//Sound
		private var introChannel: SoundChannel;//channel for introSound
		private var introSound: IntroSound = new IntroSound();

		//Logic
		private var gamePlaying: Boolean = false;//game's INITIAL STATE is paused
		private var firstClick: Boolean = true;//only play introSound on THE FIRST click
		public var howManyShotsFired: int = 0;//keep track of how many shots the player has fired as a SCORE
		
		/**CONSTRUCTOR**/
		public function Simulator(owner: DisplayObjectContainer)
		{
			/**Location**/
			//Place the simulator in the center of the stage because it is a Sprite and has its origin at 0,0 [centered]
			this.x = owner.stage.stageWidth/2;
			this.y = owner.stage.stageHeight/2;
			
			/**Add to Stage**/
			owner.addChild(this);
			
			/**GRAPHICAL HUD**/
			/**Button**/
			//Default button state: TITLE, SIZE, AND FUNCTION
			startStopButton = new Button("PLY", 0, 100, 50, handleButton);
			
			//Location
			startStopButton.x = -25;
			startStopButton.y = -400;
			
			//Size
			startStopButton.scaleX = 0.5;
			startStopButton.scaleY = 0.5;
			
			//Add to simulator
			this.addChild(startStopButton);
			
			/**Scoreboard**/
			//Create scoreboard
			scoreboard = new Scoreboard(this);				
			
			
			
			
			/**ACTIVE OBJECTS**/
			
			/**Movers**/
			movers = new Vector.<Mover>(16);
			
			//Player and Target
			movers[0] = new Player(this);
			movers[1] = new Target(this);

			//Barriers
			//LOWER 7 going from left to right
			movers[2] = new Barrier(this, -300, 240,  90,  7, 80, 0x00EE00);
			movers[3] = new Barrier(this, -200, 120,  60,  6, 60, 0x00EE00);
			movers[4] = new Barrier(this, -100,  60,  30,  5, 50, 0x00EE00);
			movers[5] = new Barrier(this,    0,   0,  90,  1, 20, 0x00EE00);
			movers[6] = new Barrier(this,  100,  60, -30, -5, 50, 0x00EE00);
			movers[7] = new Barrier(this,  200, 120, -60, -6, 60, 0x00EE00);
			movers[8] = new Barrier(this,  300, 240, -90, -7, 80, 0x00EE00);	
			
			//UPPER 7 going from left to right
			movers[9]  = new Barrier(this, -250, -240,  90,  -7, 80, 0x00EE00);
			movers[10] = new Barrier(this, -150, -120,  60,  -6, 60, 0x00EE00);
			movers[11] = new Barrier(this,  -50,  -60,  30,  -5, 50, 0x00EE00);
			movers[12] = new Barrier(this,    0,    0,  90,  -1, 20, 0x00EE00);
			movers[13] = new Barrier(this,   50,  -60, -30,   5, 50, 0x00EE00);
			movers[14] = new Barrier(this,  150, -120, -60,   6, 60, 0x00EE00);
			movers[15] = new Barrier(this,  250, -240, -90,   7, 80, 0x00EE00);
			
			
			/**Colliders**/
			colliders = new Vector.<Collider>(15);
				
			//Target
			colliders[0] = (Collider)(movers[1]);
			
			//Barriers
			colliders[1] = (Collider)(movers[2]);
			colliders[2] = (Collider)(movers[3]);
			colliders[3] = (Collider)(movers[4]);
			colliders[4] = (Collider)(movers[5]);
			colliders[5] = (Collider)(movers[6]);
			colliders[6] = (Collider)(movers[7]);
			colliders[7] = (Collider)(movers[8]);
			colliders[8] = (Collider)(movers[9]);
			colliders[9] = (Collider)(movers[10]);
			colliders[10] = (Collider)(movers[11]);
			colliders[11] = (Collider)(movers[12]);
			colliders[12] = (Collider)(movers[13]);
			colliders[13] = (Collider)(movers[14]);
			colliders[14] = (Collider)(movers[15]);
			
			/**Shooters**/
			shooters = new Vector.<Shooter>(1);
			
			//Player
			shooters[0] = (Shooter)(movers[0]);//movers[0] is the player that can move AND shoot
							
			/**LOGIC**/
			this.addEventListener(KeyboardEvent.KEY_DOWN, simulatorHandleKeyDown);
		}
		
		/**FUNCTION TO CREATE BALL SHOT AND UPDATE SCORE ACCORDINGLY**/
		protected function simulatorHandleKeyDown(event:KeyboardEvent):void
		{
			//user presses space or shift
			if (event.keyCode == Keyboard.SPACE || event.keyCode == Keyboard.SHIFT)
			{
				if(howManyShotsFired >= 99 || movers.length <= 16)//limit shots
				{
					//Play sound
					shooters[0].shoot();
					
					//Update score
					howManyShotsFired++;
					scoreboard.updateScore(howManyShotsFired);
					
					//Create ball
					var shotFired: Ball= new Ball(this);
					
					//Set x position equal to player x position
					shotFired.setX( movers[0].getX());
					
					//add ball to movers vector (logic)
					movers.push(shotFired);
				}
			}

		}
		
		/**EVERY FRAME, this function is called to update EVERY OBJECT graphically and logically**/
		private function updateAll(event:Event):void
		{
			/**MOVEMENT**/
			for each(var moverElement:Mover in movers)
			{
				moverElement.move();//every mover calls their move function every frame
				
				//Remove ball after it leaves the screen
				if(moverElement.getY() < -450)
				{
					//remove from GUI
					this.removeChild(movers[movers.length - 1] as Sprite);
					
					//remove from logic
					movers.pop();
				}
			}
	
			/**COLLISIONS**/
			for each(var colliderElement:Collider in colliders)
			{
				if (movers.length == 17)
				{
					//-------------Pixel Collision---------
					//A collider and ball collide
					if ( GUI_Collision_Detection.isColliding( colliderElement as Sprite, movers[movers.length - 1] as Sprite ) )
					{
						/**TEST CODE**/
						//trace("collision!");

						//The ball and the TARGET collide
						if( GUI_Collision_Detection.isColliding( colliders[0] as Sprite, movers[movers.length - 1] as Sprite ) )
						{
							//Remove BALL from stage(GUI)
							this.removeChild( movers[movers.length - 1] as Sprite);
							
							//Remove TARGET from stage(GUI)
							this.removeChild( movers[1] as Sprite);
							
							//Remove TARGET from LOGIC
							movers.splice(1,1);
							colliders.splice(0,1);
							
							//Remove last mover element (ball) in vector (LOGIC)
							movers.pop();
							
							//PAUSE game
							stage.removeEventListener(Event.ENTER_FRAME, updateAll);
						}
						//Ball only collides with barrier
						else
						{
							//Remove BALL from stage(GUI)
							this.removeChild( movers[movers.length - 1] as Sprite);
							
							//Remove last mover element(BALL) in vector (LOGIC)
							movers.pop();
						}
					}
					
					
					//-------------Bounding Box Collision---------
					/*
					if( colliderElement.collide( movers[16] as Sprite ) )
					{
						this.removeChildAt(5);
						movers.pop();
					}
					*/
				}
			}
		}
		
		
		/**When button is CLICKED function**/
		private function handleButton(e:Event):void
		{
			//PAUSE the game
			if(gamePlaying)
			{
				/**LOGIC**/
				//Game State
				stage.removeEventListener(Event.ENTER_FRAME, updateAll);//stops updating game state every frame
				gamePlaying = !gamePlaying;//the game is NOT playing (paused) STATE: TRUE -> FALSE
				
				/**GUI**/
				
				/**Button**/
				//Switch state from "PSE" to "PLY"
				this.removeChild(startStopButton);//remove from simulator
				
				//Create new button
				startStopButton = new Button("PLY", 0, 100, 50, handleButton);
				
				//Size
				startStopButton.scaleX = 0.5;
				startStopButton.scaleY = 0.5;
				
				//Position
				startStopButton.x = -25;
				startStopButton.y = -400;
				
				//Add to simulator
				this.addChild(startStopButton);
			}
			else//PLAY the game
			{
				/**LOGIC**/
				//Intro Sound only plays on FIRST CLICK
				if (firstClick == true)
				{
					introChannel = introSound.play();
					firstClick = false;//never play again on button click
				}			
				
				//Game State
				stage.addEventListener(Event.ENTER_FRAME, updateAll);//game begins to update state every frame
				gamePlaying = !gamePlaying;//the game IS playing, Initial State: FALSE -> TRUE
				
				//Switch focus to Player from Button
				stage.stageFocusRect = false;//DO NOT draw a focus rectangle around player
				stage.focus = (InteractiveObject)(movers[0]);//focus on Player
				
				/**GUI**/
				
				/**Button**/
				//Switch state from "PLY" to "PSE"
				this.removeChild(startStopButton);//remove from simulator
				
				//Create new button
				startStopButton = new Button("PSE", 0, 100, 50, handleButton);
				
				//Size
				startStopButton.scaleX = 0.5;
				startStopButton.scaleY = 0.5;
				
				//Position
				startStopButton.x = -25;
				startStopButton.y = -400;
				
				//Add to simulator
				this.addChild(startStopButton);
			}
			
		}
		
	}//end class
}//end package