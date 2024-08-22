# Linux L2 Bash Monorepo 

- The proposed monorepo structure organizes Bash scripts by category, stores configurations, documentation, and tests in dedicated directories, and promotes reusability with a shared lib/ directory. 

- It also introduces a projects/ directory for project-specific scripts, enhancing modularity, scalability, and maintainability while ensuring cross-platform compatibility through structured organization and testing.

### Monorepo Structure 

```
bash-scripts-repo/
│
├── README.md
├── LICENSE
├── .github/
│   ├── workflows/
│   │   └── shellcheck.yml
│   └── ISSUE_TEMPLATE/
│
├── scripts/
│   ├── os/
│   │   ├── linux/
│   │   ├── macos/
│   │   └── windows/
│   │
│   ├── network/
│   ├── backups/
│   ├── monitoring/
│   ├── security/
│   ├── utilities/
│   │
│   ├── projects/                      # Directory for project-specific scripts
│   │   ├── project1/                  # Scripts specific to Project 1
│   │   │   ├── deploy.sh
│   │   │   ├── setup.sh
│   │   │   └── config.sh
│   │   │
│   │   ├── project2/                  # Scripts specific to Project 2
│   │   │   ├── backup.sh
│   │   │   ├── cleanup.sh
│   │   │   └── monitor.sh
│   │   │
│   │   └── project3/                  # Scripts specific to Project 3
│   │       ├── firewall.sh
│   │       ├── security_audit.sh
│   │       └── update.sh
│
├── config/
│   ├── system/
│   ├── network/
│   └── application/
│
├── docs/
│   ├── network/
│   ├── backups/
│   └── templates/
│
├── tests/
│   ├── unit/
│   ├── integration/
│   └── testdata/
│
└── lib/
    ├── logging.sh
    ├── validation.sh
    ├── network.sh
    └── utils.sh

```

### Key Components

- **`scripts/`**: This is the main directory where all bash scripts are organized by category. For example, scripts related to OS-specific tasks, networking, backups, security, etc.

- **`config/`**: Stores configuration files and templates that can be used by scripts. These are also organized by system, network, and application contexts.

- **`docs/`**: Contains documentation specific to different types of scripts. It might include usage examples, environment setup instructions, or detailed explanations of complex scripts.

- **`tests/`**: Includes unit and integration tests for the scripts, ensuring they work as expected. Test data can be stored in the `testdata/` subdirectory.

- **`lib/`**: A directory for shared libraries and functions that can be sourced by scripts. This promotes code reuse and consistency across the scripts.

- **`README.md`**: Provides an overview of the repository, instructions for using the scripts, contributing guidelines, and any other important information.

- **`.github/`**: Contains GitHub Actions workflows for CI/CD, such as running ShellCheck to lint the scripts, and issue templates to streamline contributions and bug reporting.
- **`projects/` Directory**: A new directory under `scripts/` named `projects/` is created to house all project-specific scripts.
  
- **Project Subdirectories**: Each project has its own subdirectory (`project1/`, `project2/`, etc.) within the `projects/` directory. This keeps scripts organized by the project, preventing them from cluttering the general-purpose script directories.

- **Project-Specific Scripts**: Scripts related to specific projects are stored within their respective project subdirectories, making it easy to manage and identify scripts that belong to particular projects.

### Benefits for project-isolation

- **Isolation of Project-Specific Logic**: Keeping project-specific scripts in their dedicated subdirectories prevents them from interfering with general-purpose scripts and allows for easy navigation.

- **Scalability**: As more projects are added, their scripts can be organized in separate subdirectories, making the monorepo scalable.

- **Reusability**: Common utilities and libraries in the `lib/` directory can be reused across both general and project-specific scripts, promoting code reuse.

- **Consistency**: This structure maintains a consistent organization pattern, making it easier for team members to locate and manage scripts.


### Benefits of a monorepo structure

1. **Modularity**: Each script has a clear purpose and is organized by function, making it easier for sys admins to find and use what they need.
  
2. **Reusability**: The `lib/` directory encourages the reuse of common functions, reducing redundancy.

3. **Scalability**: The structure can easily scale with more scripts, categories, and tests as the repository grows.

4. **Maintainability**: With organized documentation and testing, maintaining the scripts becomes simpler and more reliable.

5. **Cross-Platform Consideration**: By separating OS-specific scripts, you can ensure that scripts behave as expected across different environments.

6. To accommodate project-specific scripts within the proposed monorepo structure, you can introduce a dedicated directory for each project under the `scripts/` directory. This approach maintains the modularity and organization while keeping project-specific scripts clearly separated from general-purpose scripts.

## Reviewdog ShellCheck Workflow

This GitHub Actions workflow is designed to run ShellCheck on shell scripts within the repository. It ensures that your scripts adhere to best practices and are compatible across different operating systems. Below is a breakdown of how the workflow is configured:

```yaml
name: reviewdog-shellcheck
on: [pull_request]
jobs:
  shellcheck:
    name: runner / shellcheck
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: shellcheck
        uses: reviewdog/action-shellcheck@v1
        with:
          github_token: ${{ secrets.ACCESS_TOKEN_FOR_REVIEW_DOG_YOU_MUST_ADD_YOUR_OWN }}
          reporter: github-pr-review 
          path: "." # Optional.
          pattern: "*.sh" # Optional.
          exclude: "./.git/*" # Optional.
          check_all_files_with_shebangs: "false" # Optional.

```

### Workflow Breakdown

- **Name and Trigger**: The workflow is triggered on every pull request (`on: [pull_request]`) to ensure that new changes to the codebase are checked immediately.

- **Cross-Platform Compatibility**: The job runs on multiple operating systems (`ubuntu-latest`, `macos-latest`, `windows-latest`) using a matrix strategy. This ensures that the shell scripts work consistently across different environments.





