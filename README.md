# Manipulator-scheduling
non-classic manipulator scheduling, using greedy and pruning algorithm, based on Plato path

Problem Background:
---------------

![image](http://github.com/JasmineJiali/Manipulator-scheduling/raw/master/img.png)
      
In Figure 1, In and Out are the entrance and exit of the product, In stores the product to be processed, and Out stores the finished
product. Pre and Post are the preparation chambers for processing products and the testing chambers after processing. P1, P2,..., P6 are
the six processing chambers of the product, the product will be processed in these different processing chambers in a variety of processes.
Buffer is the buffer chamber connecting two devices, which is responsible for the transmission between two devices. R1 and R2 are two
manipulators responsible for taking and placing the product before and after the chamber processing and the transfer between the chambers
in the equipment. R1 can go back and forth between In, Out, Pre, Post and Buffer, R2 can go back and forth between P1, P2,..., P6 and
Buffer. For simplicity, we call the mobile device of the manipulator R1 the first device, and the mobile device of the manipulator R2 the
second device.

In the process of product processing, sometimes there will be more than one action to complete, but each manipulator can only does at most
one action at each time. The order of execution of these actions will have a great impact on the processing time of the products. In the
actual production, it is necessary to find the optimal scheduling sequence of manipulators, so that the factory can complete the product
processing task in the shortest time. Obviously, there are many feasible scheduling sequences for manipulators, and our task needs to find
the best scheduling scheme among them under different situations.

There are three kinds of processing modes here in total, in different folders. We need to find the best scheduling schemes under these three modes.

Problem solving sequence：
-------------------------
single-processing-mode  =>  multi-processing-mode  =>  multi-products-processing-mode
