# Drug-AI-V2: Modular Azure Infrastructure for Drug Discovery Platform

This Terraform project provisions a modular and scalable cloud environment on Azure for hosting a distributed drug discovery platform, including AutoGen, LangGraph, ADiT, and other ML/AI services. This version (`drug-ai-v2`) supports multi-GPU VMs, container apps with GitHub Container Registry (GHCR) integration, and NFS-based shared storage.

---

## 📂 Project Structure

```
terraform-drug-ai-v2/
├── main.tf                  # Root configuration entrypoint
├── variables.tf             # Global input variables
├── outputs.tf               # Global output variables
├── .env.auto.tfvars         # Secrets and per-deployment config
├── modules/
│   ├── resource-group/
│   │   └── main.tf
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── bastion/
│   │   └── main.tf
│   ├── vm-gpu/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── shared-nfs/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md                # This documentation file
```

---

## 🔁 Deployment Sequence

```
[1] resource-group
    ↓
[2] network (VNet + subnets)
    ↓
[3] bastion
    ↓
[4] vm-gpu (ctrl / worker VM)
    ↓
[5] shared-nfs (Azure Files Premium with NFS)
    ↓
[6+] app-specific ACA (AutoGen, LangGraph, etc.)
```

---

## 🔐 Secrets & Config (.env.auto.tfvars)

```
prefix              = "drug-ai-v2"
location            = "westus3"
resource_group_name = "rg-drug-ai-v2"

admin_username      = "lilabu01"
ssh_key_path        = "~/.ssh/id_rsa.pub"

ghcr_pat            = "ghp_***"  # GitHub token for pulling container images
github_user         = "your-gh-username"

azure_openai_api_key     = "sk-..."
azure_openai_base_url    = "https://your-openai-endpoint/"
azure_openai_api_version = "2024-12-01"
azure_openai_deployment  = "gpt-4o-drug-ai"

tags = {
  project = "drug-ai-platform"
  env     = "prod"
}
```

---

## 🚀 Deployment Instructions

```bash
cd terraform-drug-ai-v2
terraform init
terraform plan
terraform apply
```

You may be prompted for `github_user` if not provided in `.env.auto.tfvars`.

---

## 🧩 Design Notes

- **Azure Bastion** enables secure SSH to VM without exposing public IP.
- **VM-gpu** module supports GPU-enabled nodes for ADiT, AlphaFold2, etc.
- **Shared-NFS** module provisions Azure Files Premium with `/mnt/shared-data/{inputs,models,outputs}`.
- **AutoGen/LangGraph** modules (not included here) read shared configs from env and NFS mount points.

---

## 🧼 Cleanup

To destroy all resources:

```bash
terraform destroy
```

---

## 📌 Compatibility

- Terraform ≥ 1.3
- Azure Provider ≥ 3.80
- Compatible with Ubuntu 22.04 LTS (for VM)
- GHCR + Azure OpenAI tested

---