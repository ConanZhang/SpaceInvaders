/**
 * 
 * File:		Mover.as
 *
 * Author:		Georbec Ammon (u0552984@utah.edu)& Conan Zhang (conan.zhang@utah.edu)
 * Date: 		11-4-13
 * Partner:		Georbec Ammon/ Conan Zhang
 * Course:		Computer Science 1410 - EAE
 *
 * Description:
 *
 * Mover interface contains only move().
 * 
 **/
package circledefense
{
	//ALL MOVERS MUST HAVE A MOVE, getX, and getY FUNCTION!!!
	public interface Mover
	{
		function move(): void;
		function getX(): int;
		function getY(): int;

	}
}