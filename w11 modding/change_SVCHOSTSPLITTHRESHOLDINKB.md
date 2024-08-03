from: https://raw.githubusercontent.com/bliku/SVCHOSTSPLITTHRESHOLDINKB/main/README.md
and adapted.

-----

<h1> How to Change Split Threshold for svchost.exe in Windows 10/11 </h1>

In Windows, the **SvcHostSplitThresholdInKB** is a registry key that determines how the system groups Windows services into instances of the *svchost.exe process*. What is *svchost.exe*? This is a generic host process that runs most Windows services. Each service can be loaded into a separate instance of *svchost.exe*, making resource management and monitoring easier. This key defines the memory threshold (in kilobytes) at which Windows will separate services into different *svchost.exe* instances. If the combined memory usage of services hosted by a single *svchost.exe* exceeds this threshold, Windows will create a new instance to distribute the load.

By default, **SvcHostSplitThresholdInKB** is set to 380,000 KB (around 370MB). This means services will be grouped into different *svchost.exe* processes until their combined memory usage reaches this limit.

It is recommended to set **SvcHostSplitThresholdInKB** to the size of your memory.

Here's How:

- Press the _Win + R_ keys to open Run, type _regedit_ into Run, and click/tap on OK to open Registry Editor.

- Go to **Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control** and edit the key named **SvcHostSplitThresholdInKB** to match your PCs memory in KB.

| RAM             | Value    |
|:---------------:|:--------:|
| **(default)**   | 380000   |
| 4 GB            | 400000   |
| 6 GB            | 600000   |
| 8 GB            | 800000   |
| 12 GB           | c00000   |
| 16 GB           | 1000000  |
| 24 GB           | 1800000  |
| 32 GB           | 2000000  |
| 64 GB           | 4000000  |

***Then reboot for the changes to take affect. Your Task Manger processes should decrease after you do this!***
