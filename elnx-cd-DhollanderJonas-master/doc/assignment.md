# Continuous Delivery pipeline

In the enterprises behind the big websites (e.g. Google, Amazon, Facebook, Twitter, etc.), one of the roles of a system administrator is to support software developers in delivering new features into production as quickly as possible, while maintaining software quality. This role is sometimes called "Release Engineering". In a "classical" setup, releases are large, contain many new features and have high impact on the daily operations. They are regularly organized during the weekend, and cause a lot of stress and anxiety. Bugs are commonly found during these release events, which may disrupt business. One approach is to minimize impact of releases by doing them more often, but with smaller impact, e.g. a single improvement or feature. To achieve this, a development team needs specific infrastructure and tooling. The entire process of bringing code into production has to be automated, which includes running extensive test suites. The term "Continuous Integration" (CI) is used when the flow of code is automated up to the point where it is ready to be put into production. That final step is only taken after human intervention. When the release of code is also automated, it's called "Continuous Deployment" (CD).

The goal of this assignment is to set up and demonstrate a "pipeline" for web development:

- The developers write code on their laptop, running the application in a "development environment," e.g. a virtual machine set up with Vagrant.
- When developers push code to a Git repository, the CI/CD tool will start a build process that may consist of:
    - static code analysis, linting (= automated coding style checks);
    - compilation (in the case of a compiled language);
    - running unit tests;
    - packaging (e.g. RPM, Ruby Gem, ...).
- Code that passes these tests is promoted to a "QA environment". Typically, this is a virtualized environment that mimics the production environment as closely as possible. In this phase other types of tests are run: integration tests, acceptance tests, stress tests, etc.
- Code that passes this battery of tests is considered to be ready for production and is released onto the "production environment"

## Requirements

This assignment is exploratory, and the end result is not defined in detail. That does not mean that it is non-committal, though. You are expected to aim for *high quality code*, a working solution that could be *used in reality*, and a *deep insight* in the system you have set up.

- Read about CI/CD in technical literature: what tools are used, what techniques, how are development pipelines structured? Collect what you have read, write down the highlights.
- Find a good case that can be used as a demo, e.g. an open source web application with an extensive automated test suite.
- Set up at least three "environments":
    - a development environment powered by Vagrant that can be easily used by a programmer
    - a QA environment, e.g. powerd by a virtualization platform on "bare metal" (hardware will be made available). Possibilities include KVM (hypervisor built into the Linux kernel), OpenNebula, OpenStack.
    - a production environment on a cloud provider, e.g. Amazon Web Services or DigitalOcean
- The configuration of VMs in the three different environments should be identical, or at least as similar as possible. Specific tools exist for this, e.g. Packer.
- Choose a CI/CD tool, e.g. Jenkins, ...
- The complete setup is automated using Ansible. It has to be possible to set up the entire system with no manual intervention

It is important to show your progress regularly. Work iteratively and make sure you have something working as soon as possible (a *Minimum viable Product*). It is perfectly normal that your first solution lacks major parts of the requirements (e.g. no QA/production environment). Discuss milestones with your teacher.

