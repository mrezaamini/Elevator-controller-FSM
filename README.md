# ELEVATOR CONTROLLER FSM IMPLEMENTATION (VHDL)
In this project, I implemented a simple finite state machine of a 4-floor elevator using VHDL. It's a good example to see how you can implement finite state machines in VHDL. There's an extra part in this implementation that uses text file input as testbench that is described in the test part below.

## Table of Contents
- [Description](#description)
- [TEST](#test)
- [Support + Feedback](#support--feedback)
- [Thank You](#thank-you)
- [License](#license)

## Description:
FSM of this elevator controller consists of three states: idle, moving, and reset. The idle state is the state in which the elevator stops and evaluate the situation and check pending request (PendingReq) to decide what to do. In this implementation, I assume that the elevator's door closing and opening time are zero and we control it with an input signal called Switch. Moving state is for showing us that the elevator is moving and FSM goes into reset state whenever we want to reset the controller (elevator in floor one and nothing is happening. with no pending requests).
<br></br>
<p align="center">
<img src="https://github.com/mrezaamini/Elevator-controller-FSM/blob/main/assets/elevator.png" alt="4-level elevator" width="350" />
</p>


- come[0..3]: 4-bit input, each floor has it's own button and this signal shows us which floor's button in the building is pushed.
- cf[0..3]: 4-bit input, shows us pushed buttons inside the elevator.
- switch[0..3]: 4-bit input, there is a switch in each floor that turns 1 whenever the elevator reaches to that specific floor.
- motor-up: 1-bit output, 1 when elevator is moving up.
- motor-down: 1-bit output, 1 when elevator is moving down.
- current-floor: in this implementation is 4-bit output that shows which floor is elevator in (for showing it inside the cabin).
- move-state: 1-bit output, 1 when elevator is moving and 0 when it stops.

## TEST:
The main test is with a simple testbench that initiates a clock (clk) and changes inputs over time.
In Addition, there's another testbench in the "text file testbench" folder that contains testbench, supporting package, and input text file. (for further information about this testbench click [here](https://mrezaamini.github.io/Elevator-controller-FSM/). )
Tests are done with modelSim simulator. 
Test Example:
<br></br>
<p align="center">
<img src="https://github.com/mrezaamini/Elevator-controller-FSM/blob/main/assets/test.png" alt="test"/>
</p>

## Support + Feedback

Include information on how to get support.
- easily contact me with [email](aminiamini433@yahoo.fr)

## Thank You

Thanks for paying attention, and hope this contest was usefull for you!

## License
Link to [LICENSE](LICENSE) doc.