cat <<EOF > Jenkinsfile
pipeline {
    agent any
    parameters {
        string(name: 'vm_name', defaultValue: 'docker-vm', description: 'Name of the VM')
        string(name: 'vm_template', defaultValue: 'docker-template', description: 'VM template to use')
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/ch-ademo/vm-deployment-automation.git'
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                ansiblePlaybook(
                    playbook: 'ansible/playbooks/create_vm.yml',
                    inventory: 'ansible/inventory/hosts.ini',
                    credentialsId: 'vcenter-credentials',
                    extras: '-e vm_name=${vm_name} -e vm_template=${vm_template}'
                )
            }
        }
    }
}
EOF
