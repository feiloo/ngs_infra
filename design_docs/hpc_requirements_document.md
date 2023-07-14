# Draft: Technical requirements for HPC in Molecular Pathology:


| Author        | Florian Hoelscher   |
| ----          | ----                |
| Date          |          14.07.2023 |
| Draft version |                   4 |

----

This is a draft requirements estimation for HPC in molecular Pathology from the Institute of Pathology at the UKB.
It is very much subject to change!
It estimates the requirements for clinical/production hpc workloads.
The users are Patrick Basitta, Florian Hoelscher.

Because we currently have no access to GPU Resources, we could not estimate or develop GPU Acceleration for our "Pipeline".

Laxmi Gupta is working on Digital Pathology and has her own different requirements.

We require HPC for batch jobs to analyse gene-data.
Our HPC client software will soon be [Nextflow](https://www.nextflow.io/) or if necessary custom adapter scripts/software.
See the description below about Nextflow.

Our two usecases are currently integration testing and clinical HPC jobs.

## Usecase: Clinical jobs 

Clinical jobs are batch jobs with varying batch size.

Cliical jobs should be done in less than 2 days lower the delay of patient care and burden on pathologist because of work-buildup
Clinical jobs must be done within a week, to not cause issues with the above

There are different clinical job types below.
The table specifies high average baseline requirements for running patient-cases unbatched.

| job-type-name        | jobs/month | core-hours/job | ram/job | gpu-hours/job | vram/job | storage/job |
| ---                  | ---        | ---            | ---     | ----          | ----     | ---         |
| small targeted panel | 320        | 1.8            | 8       |             ? |        ? | 200MB       |
| big targeted panel   | 8          | 32             | 8       |             ? |        ? | 200MB       |
| whole exome analysis | 15         | 160            | 128     |             ? |        ? | 40GB        |

## Usecase: Continuous integration test jobs

These jobs are used to continuously verify every change to our analysis against real data.

Test jobs will likely run a few of each clinical job type.
More than 3 test job executions per week are preferable to aid development.

Test jobs should be done within a week.
Test jobs must be done within a month to get frequent updates and releases
Test jobs can likely be preempted or cancelled and rescheduled for running higher priority jobs.


In a year there can possibly be research hpc jobs that are similar to whole exome analysis type jobs, 
but lower priority and preferably preemptable.

Additionally, we ordered an Supermicro GPU HPC Server to research and possibly integrate novel gpu accelerated algorithms into our analysis.
As of now we still dont have access to this server.


### About Nextflow and our Analysis Pipeline
Nextflow has multiple "executors", e.g. [slurm executor](https://nextflow.io/docs/latest/executor.html?highlight=slurm#slurm) or [kubernetes](https://nextflow.io/docs/latest/kubernetes.html)
Nextflow can package "tasks" inside of containers, so running containers and the issues of "nested containerization" have to be considered for deployment.

The Nextflow Software was chosen by our work-group [CIO-ABCD](https://www.ciobonn.de/) and the development can be followed on our [github.com/cio-abcd](https://github.com/cio-abcd/variantinterpretation).
