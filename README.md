# atmfd
Type 1 Font Parsing Remote Code Execution Vulnerability Mitigation

A vulnerability has recently been released in the Adobe Type Manager Library, which allows an attacker to run code with kernel permissions if the victim opens a file or in Windows font preview.
There are three ways to mitigate the problem, but they are highly system dependent. 
Disable the Windows preview panel from Explorer (the file viewer, not the browser), Disable WebClient service and Rename ATMFD.DLL.
For more information see: https://portal.msrc.microsoft.com/en-us/security-guidance/advisory/adv200006

Below, you can see the script that I have created to carry out the process mentioned above.
Feel free to use and improve it.
