
# Splunk Admin Automation

## Overview

The **Splunk Admin Automation** project provides a set of Python scripts to automate common and complex Splunk administrative tasks. This tool simplifies processes such as managing indexes, monitoring health, sending alerts, and performing system checks, making the lives of Splunk administrators more efficient and reliable.

This project helps reduce the manual work involved in Splunk administration by automating routine tasks, and ensures better monitoring, system health, and alerting through scheduled tasks.

## Features

* **Index Management**: Automate the creation, configuration, and management of Splunk indexes.
* **Health Monitoring**: Perform system health checks on Splunk instances, ensuring that everything runs smoothly.
* **Scheduled Task Execution**: Schedule automated tasks to ensure system maintenance is performed without manual intervention.
* **Alert Notifications**: Automatically send email alerts based on specific conditions or events.
* **Deployment and Configuration Automation**: Simplify the configuration and deployment of Splunk apps and configurations.

## Getting Started

These instructions will help you set up the project and get it running locally.

### Prerequisites

Ensure you have the following installed:

* **Python 3.x** (recommended version: 3.8+)
* **Splunk Enterprise** (configured and running, can be installed in a local/VM environment)
* **Git** (to clone the project repository)
* **Email Configuration** (for email notifications)

### Installation

1. **Clone the repository**:

   ```bash
   git clone git@github.com:tfasanya79/splunk-admin-automation.git
   cd splunk-admin-automation
   ```

2. **Install required dependencies**:
   The project uses several Python packages. You can install them with the following command:

   ```bash
   pip install -r requirements.txt
   ```

3. **Configure your Splunk environment**:
   Copy the sample configuration file to create your local configuration:

   ```bash
   cp config/splunk_instances.yaml config/splunk_instances.local.yaml
   ```

   Then, edit the `splunk_instances.local.yaml` file to provide your Splunk instance details (e.g., `host`, `username`, `password`).

4. **Set up Email Notifications (Optional)**:
   If you want email alerts to be sent from the scripts, make sure to configure the email settings in the `config/email_config.yaml`.

### Usage

The automation scripts are divided into several functional areas. Here's how you can use them:

1. **Create an Index**:
   To create a new index in Splunk with custom settings (e.g., retention policies), run:

   ```bash
   python scripts/deploy_indexes.py --env dev --index_name my_new_index --retention 90d
   ```

2. **Check Splunk Health**:
   Run a quick health check on your Splunk instance:

   ```bash
   python -c "from modules.health_monitoring import get_indexer_health; get_indexer_health('dev')"
   ```

3. **Start Scheduled Health Monitoring**:
   To run health checks at scheduled intervals, you can start the health monitoring process:

   ```bash
   python scripts/start_health_scheduler.py --env dev
   ```

4. **Send Test Email Alert**:
   If you want to send a test email alert:

   ```bash
   python -c "from modules.email_notifications import send_email_notification; send_email_notification('Splunk Alert', 'Test email sent from automation lab')"
   ```

5. **Automate Index Management**:
   Use the provided `manage_indexes.py` script to manage multiple indexes (creating, deleting, modifying settings) in a batch process.

### Scheduled Tasks

You can set up automated tasks using the `schedule` library for running health checks or creating indexes. The tasks are configured in the `scheduler.py` file, where you can define the frequency of various tasks, such as checking system health or managing indexes at set intervals.

### Contribution

If you'd like to contribute to this project:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-xyz`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-xyz`).
5. Open a pull request.

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Project Structure

Here's an overview of the project directory structure:

```
splunk-admin-automation/
│
├── config/                          # Configuration files for Splunk instances and email
│   ├── splunk_instances.yaml        # Example Splunk instance configuration
│   └── email_config.yaml           # Email notification configuration
│
├── modules/                         # Core functionality for Splunk automation
│   ├── health_monitoring.py         # Health check scripts
│   ├── email_notifications.py       # Email notification functionality
│   └── deploy_indexes.py            # Script for index management
│
├── scripts/                         # Main scripts to be executed
│   ├── deploy_indexes.py            # Deploy indexes script
│   ├── start_health_scheduler.py    # Schedule health checks
│   └── start_automation.py          # Main script to trigger automation
│
├── requirements.txt                 # Python dependencies
├── README.md                        # Project documentation
└── LICENSE                          # License file for the project
```

### Additional Information

* **Health Monitoring**: This module checks the health of Splunk indexers and search heads, ensuring that your Splunk environment is running optimally.
* **Email Notifications**: Sends email notifications when specific events or thresholds are met in the Splunk environment.
* **Index Management**: Handles the creation, modification, and deletion of Splunk indexes. This feature allows administrators to automate the maintenance of data retention policies and index configurations.

---

## Troubleshooting

1. **Error: `Could not connect to Splunk instance`**:

   * Check the `splunk_instances.local.yaml` configuration for correctness.
   * Ensure Splunk is running on the expected host and port.

2. **Error: `Failed to send email`**:

   * Ensure that the `email_config.yaml` file contains the correct SMTP server settings.
   * Verify that your email service is available and that the credentials are correct.

3. **Script fails to execute scheduled task**:

   * Ensure that the `schedule` package is installed correctly.
   * Check for any issues in the scheduled task configuration in `scheduler.py`.

---

### Contact

For any questions or feedback, feel free to reach out to the project maintainers:

* **Tim Fasanya** (timothy.fasanya79@gmail.com)

