# Draft: Usecases for Computation (HPC) in Molecular Pathology:


| Author        | Florian Hoelscher   |
| ----          | ----                |
| Date          |          27.07.2023 |
| Draft version |                   5 |

----

This is a draft requirements document for HPC usecases for molecular Pathology at the UKB Institute of Pathology.
It is very much subject to change!
The users are Patrick Basitta, Florian Hoelscher.
Laxmi Gupta is working on Digital Pathology and has her own different requirements.

Our HPC client software will soon be [Nextflow](https://www.nextflow.io/) or if necessary custom adapter scripts/software.
See the description below about Nextflow.

#### Clarification:

By HPC or high performance computation, we (Patrick and Florian) mean computation that runs comparitively fast to other workloads.
It doesnt entail for us, how or where the computation takes place, whether supercomputer or a high available cluster.

#### Motivation

The rapid developments in bioinformatics and next generation sequencing cause an increase in the compute and storage requirements.
Additionally, we intend to speed up the patient care by accelerating our computational analyses.
Some analyses and new tools lend themself to gpu acceleration, so we need to evaluate and learn the use of accelerators.

## Usecases

### Usecase 1: New clinical pipeline

Clinical jobs are batch jobs with varying batch size.
The batch job requirement stems from our usage of batch sequencers.
The pipeline is based on Nextflow and the development can be followed on our [github.com/cio-abcd](https://github.com/cio-abcd/variantinterpretation).


There are different clinical job types below.
The table specifies high average baseline requirements for running patient-cases unbatched.

In future, we will create many variations of Workflows, with and without gpu acceleration, depending on the tooling.

We consider accelerating some steps of the pipeline by using gpus through nvidia clara parabricks.
According to nvidia, speedups of 10x-15x are to be expected, which could greatly increase our productivity.

Nvidia clara parabricks has the following requirements

| job-type-name            | jobs/month | core-hours/job | ram/job | gpu-hours/job | vram/job | storage/job |
| ---                      | ---        | ---            | ---     | ----          | ----     | ---         |
| small targeted panel     | 320        | 1.8            | 8       |             ? |    >12GB | 200MB       |
| big targeted panel       | 8          | 32             | 8       |             ? |    >12GB | 200MB       |
| whole exome analysis     | 15         | 160            | 128     |             ? |    >12GB | 40GB        |


We need gpus to evaluate this and from the nvidia documentation and my intention, a single a100


### Usecase 2: Continuous integration for new clinical pipeline

These jobs are used to continuously verify every change to our new clinical bach analysis jobs against real data.

Test jobs will likely run a few of each clinical job type.
More than 3 test job executions per week are preferable to aid development.

Test jobs should be done within a week.
Test jobs must be done within a month to get frequent updates and releases
Test jobs can likely be preempted or cancelled and rescheduled for running higher priority jobs.


### Usecase 3: Interactive research analysis or development jobs

To integrate and update new tools into our production environment, we need to evaluate, develope and manually test them.
These research hpc jobs that can range from very small to whole exome analysis type jobs like above.

For these jobs, we ordered an Supermicro GPU HPC Server to research and possibly integrate novel gpu accelerated algorithms into our analysis.
As of now we still dont have access to this server.


### Usecase 4: Legacy clinical pipeline, CLC 

(Included for completeness, Already fulfilled)
We currently also use CLC for our production tasks, but intend to establish the new Nextflow based pipeline.
This currently runs on windows nodes with the CLC Server Software on ukb1740 and the workers: ukb1741, ukb1742, ..., ukb1746
As of now, We indend to keep the CLC Setup because of our experience with it and the nice interactivity of this tool.


### About Nextflow and our Analysis Pipeline
Nextflow has multiple "executors", e.g. [slurm executor](https://nextflow.io/docs/latest/executor.html?highlight=slurm#slurm) or [kubernetes](https://nextflow.io/docs/latest/kubernetes.html)
Nextflow can package "tasks" inside of containers, so running containers and the issues of "nested containerization" have to be considered for deployment.

The Nextflow Software was chosen by our work-group [CIO-ABCD](https://www.ciobonn.de/) 

Because we currently have no access to GPU Resources, we could not estimate or develop GPU Acceleration for our "Pipeline".
