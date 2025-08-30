class ResumeData {
  final String fullName;
  final String title;
  final String summary;
  final List<String> skills;
  final List<Experience> experience;
  final List<Project> projects;
  final List<Education> education;
  final Contact contact;

  const ResumeData({
    required this.fullName,
    required this.title,
    required this.summary,
    required this.skills,
    required this.experience,
    required this.projects,
    required this.education,
    required this.contact,
  });
}

class Experience {
  final String company;
  final String role;
  final String start;
  final String end;
  final List<String> highlights;

  const Experience({
    required this.company,
    required this.role,
    required this.start,
    required this.end,
    required this.highlights,
  });
}

class Project {
  final String name;
  final String url;
  final List<String> tech;
  final String description;
  final List<String> highlights;

  const Project({
    required this.name,
    required this.url,
    required this.tech,
    required this.description,
    required this.highlights,
  });
}

class Education {
  final String school;
  final String degree;
  final String year;

  const Education({
    required this.school,
    required this.degree,
    required this.year,
  });
}

class Contact {
  final String email;
  final String? phone;
  final String? location;
  final List<ContactLink> links;

  const Contact({
    required this.email,
    this.phone,
    this.location,
    required this.links,
  });
}

class ContactLink {
  final String label;
  final String url;

  const ContactLink({
    required this.label,
    required this.url,
  });
}
