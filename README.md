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


<p align="center">
<img src="https://github.com/mrezaamini/Elevator-controller-FSM/blob/main/assets/elevator.png" alt="4-level elevator" width="500" />
</p>

## TEST:
for testing set a and b as input numbers in testbench and simulate it with softwares like modelsim. 
Test Example:
<br></br>
![modelsim test example](https://github.com/mrezaamini/Serial-Adder/blob/main/test.png)

## Support + Feedback

Include information on how to get support. Consider adding:
- easily contact me with [email](aminiamini433@yahoo.fr)

## Thank You

Information on the dependencies used, if desired.

## License
Link to [LICENSE](LICENSE) doc.