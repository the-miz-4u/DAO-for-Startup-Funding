// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract DAOForStartupFunding {
    // Struct to store project details
    struct Project {
        string title;
        string description;
        uint256 fundingGoal;
        uint256 fundsRaised;
        bool isActive;
    }

    // Mapping to store projects by ID
    mapping(uint256 => Project) public projects;
    uint256 public projectCount;

    // Event to log project creation
    event ProjectCreated(uint256 projectId, string title, string description, uint256 fundingGoal);

    // Function to create a new project
    function createProject(string memory _title, string memory _description, uint256 _fundingGoal) public {
        projectCount++;
        projects[projectCount] = Project({
            title: _title,
            description: _description,
            fundingGoal: _fundingGoal,
            fundsRaised: 0,
            isActive: true
        });
        emit ProjectCreated(projectCount, _title, _description, _fundingGoal);
    }

    // Function to contribute funds to a project
    function contributeToProject(uint256 _projectId) public payable {
        require(projects[_projectId].isActive, "Project is not active");
        require(msg.value > 0, "Contribution must be greater than 0");
        projects[_projectId].fundsRaised += msg.value;
    }

    // Function to check project status
    function getProjectStatus(uint256 _projectId) public view returns (string memory title, string memory description, uint256 fundingGoal, uint256 fundsRaised, bool isActive) {
        Project memory project = projects[_projectId];
        return (project.title, project.description, project.fundingGoal, project.fundsRaised, project.isActive);
    }
}
