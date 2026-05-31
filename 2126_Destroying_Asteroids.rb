# @param {Integer} mass
# @param {Integer[]} asteroids
# @return {Boolean}
def asteroids_destroyed(mass, asteroids)
  asteroids.sort!
  
  asteroids.each do |asteroid|
    
    return false if mass < asteroid
    
    mass += asteroid
  end
  
  true
end

=begin
--------------------------------------------------------------------------------
EXPLANATION OF THE GREEDY APPROACH
--------------------------------------------------------------------------------
This problem is a classic example of a Greedy Algorithm. Here is the logic behind
why this specific implementation works perfectly:

1. Why Sort?
   The rule of the game is simple: you can only destroy an asteroid if your mass 
   is greater than or equal to its mass. Every time you destroy one, you gain 
   its mass. Therefore, it is always optimal to fight the smallest possible 
   asteroid available. It gives you a "free" mass boost with the lowest risk.

2. Step-by-Step Execution:
   - Imagine Example 1: mass = 10, asteroids = [3, 9, 19, 5, 21]
   - After sorting, the asteroids become: [3, 5, 9, 19, 21]
   
   - Collision 1: Planet (10) >= Asteroid (3)  -> Success! New mass = 10 + 3 = 13
   - Collision 2: Planet (13) >= Asteroid (5)  -> Success! New mass = 13 + 5 = 18
   - Collision 3: Planet (18) >= Asteroid (9)  -> Success! New mass = 18 + 9 = 27
   - Collision 4: Planet (27) >= Asteroid (19) -> Success! New mass = 27 + 19 = 46
   - Collision 5: Planet (46) >= Asteroid (21) -> Success! New mass = 46 + 21 = 67
   
   - All asteroids are cleared, so the method returns true.

3. Early Exit (Failure Condition):
   If at any point `mass < asteroid`, we instantly return false. Because the 
   array is sorted, if the planet is too small for the *current* asteroid, it 
   will definitely be too small for all the remaining asteroids after it. 

4. Complexity:
   - Time Complexity: O(N log N) because sorting the array takes N log N time,
     and walking through the loop takes O(N) time.
   - Space Complexity: O(1) auxiliary space because `.sort!` modifies the 
     input array directly in-place.
--------------------------------------------------------------------------------
=end
