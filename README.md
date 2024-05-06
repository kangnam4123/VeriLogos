😎 VeriLogos 😎
A project to create Verilog RTL that is grammatically and functionally correct, and optimized for PPA using LLM

📖 Description
[TBU]

⭐ Main Feature
Reinforcement Learning with Tool Feedback (RTTF)
[TBU]
💻 Getting Started
Docker Setting
# Docker image download 
docker pull microhumanis/rtlgen:240401

# Docker container build 
docker run -it --name <name> --gpus '"device=<0,1,2...>"' --net host -v <path/to/local>:<path/to/docker> --shm-size='16gb' microhumanis/verilogos:1.2 bash
Git
git clone https://github.com/microhumanis/VeriLogos.git
Accelerate Setting
accelerate config --config_file <path/to/config/my_config.yaml> 
Run
accelerate launch --config_file <path/to/config/my_config.yaml> main.py  
📂 Project Structure
RTLGen
├── data
│   ├── csv
│   └── modules
├── pdk
│   └── Nangate45
└── script
    ├── ref
    └── util
