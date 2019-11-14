# Bubble sort in vhdl ... just for fun

TIMING:

![alt text](https://github.com/tirfil/Bubble_sort_vhdl/blob/master/WAVEDROM/wavedrom.png)

Note: In the following implementation, RAM write is active high (= not RAMWEN).

|Pinout||
|:------------- |:-------------|
|RAMD| RAM data in
|RAMQ| RAM data out
|RAMWE| RAM write (active high)
|RAMA| RAM address
|START| start sorting
|STOP| sorting is finished
|TOP| last address to sort (first is always at address 0)
|ORDER| sort order : ascending (0) / descending (1)

