# Draft: HPC implementation


| Author        | Florian Hoelscher   |
| ----          | ----                |
| Date          |          27.07.2023 |
| Draft version |                   1 |

----

So with this document, i intend to narrow down the technical specifics for solving our hpc requirements.
Pls add your specifications here as well.

From our meeting, i got the following mental model, so pls correct this.

## Implementation Step 1: Either Testing setup or Research setup

To get started, i want to evaluate, benchmark and test nvidia clara parabricks.
So first, i would like either a server/vm/container for the "Usecase 2: Continuous integration for new clinical pipeline" in the hpc_requirements_document.md or
a server/vm/container for "Usecase 3: Interactive research analysis or development jobs".
Whether these run on the vmware cluster or an hpc system is not important.
This server/vm/container can be ephemeral, preemtable, or just a batch job in a resource scheduler.

The parabricks requirements can be found here [parabricks documentation](https://docs.nvidia.com/clara/parabricks/v3.0/text/getting_started.html#step-1-make-sure-installation-requirements-are-met)

Minimal Hardware implementation details:

| Component      | Amount                    |
| ----           | ----                      |
| CPU-Cores      | 16                        |
| RAM            | 64GB                      |
| GPU            | t4, P100, V100, or better |
| Number of GPUs | 1                         |
| VRAM           | 12GB                      |
| Storage        | 500GB                     |

Storage would preferably be a local ssd.

Software requirements:

| Software                                   | Minimum Version |
| ----                                       | ----            |
| Cuda                                       | 10.0            |
| nvidia-docker/singularity (when container) | 2.6.1           |


## Implementation Step 2: Production setup

After this testing phase, i can give you specifics on the requiements for a production setup, which would most likely then run on the "KRITIS" vmware cluster.

Since we can now apparently run gpu workloads on vmware, the vmware cluster is the best place to deploy our production pipeline.
The burstyness of these batch jobs does not seem to cause a low hardware ulitization, because the cpus and gpus will apparently automaticly be reused when idle through vmware.


From the nvidia documentation and my knowledge i estimate 2 to 4 a100-40GB gpus would be a good amount.
We would use likely run them about 10 hours per gpu per week.
The usage may be in bursts, that use them in parallel together for 1-3 hours, because we sometimes run them manually or interactively.

