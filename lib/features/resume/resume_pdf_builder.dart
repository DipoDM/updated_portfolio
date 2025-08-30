import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../core/services/resume_models.dart';

class ResumePdfBuilder {
  static Future<Uint8List> generatePdf(ResumeData resume) async {
    final pdf = pw.Document();
    
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(resume),
            pw.SizedBox(height: 20),
            _buildSummary(resume),
            pw.SizedBox(height: 20),
            _buildExperience(resume),
            pw.SizedBox(height: 20),
            _buildSkills(resume),
            pw.SizedBox(height: 20),
            _buildEducation(resume),
          ];
        },
      ),
    );
    
    return pdf.save();
  }
  
  static pw.Widget _buildHeader(ResumeData resume) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          resume.fullName,
          style: pw.TextStyle(
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          resume.title,
          style: pw.TextStyle(
            fontSize: 16,
            color: PdfColors.blue,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          '${resume.contact.email} • ${resume.contact.phone ?? ''} • ${resume.contact.location ?? ''}',
          style: const pw.TextStyle(fontSize: 12),
        ),
        if (resume.contact.links.isNotEmpty)
          pw.Text(
            resume.contact.links.map((link) => link.url).join(' • '),
            style: const pw.TextStyle(fontSize: 12),
          ),
      ],
    );
  }
  
  static pw.Widget _buildSummary(ResumeData resume) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Professional Summary'),
        pw.SizedBox(height: 8),
        pw.Text(
          resume.summary,
          style: const pw.TextStyle(fontSize: 11, lineSpacing: 1.4),
        ),
      ],
    );
  }
  
  static pw.Widget _buildExperience(ResumeData resume) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Experience'),
        pw.SizedBox(height: 8),
        ...resume.experience.map((exp) => _buildExperienceItem(exp)),
      ],
    );
  }
  
  static pw.Widget _buildExperienceItem(Experience experience) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 12),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                experience.role,
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                '${experience.start} - ${experience.end}',
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
          pw.Text(
            experience.company,
            style: pw.TextStyle(
              fontSize: 11,
              color: PdfColors.blue,
            ),
          ),
          pw.SizedBox(height: 4),
          ...experience.highlights.take(4).map((highlight) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 2),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('• ', style: const pw.TextStyle(fontSize: 10)),
                pw.Expanded(
                  child: pw.Text(
                    highlight,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
  
  static pw.Widget _buildSkills(ResumeData resume) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Skills & Technologies'),
        pw.SizedBox(height: 8),
        pw.Wrap(
          spacing: 8,
          runSpacing: 4,
          children: resume.skills.map((skill) => pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: pw.BorderRadius.circular(4),
            ),
            child: pw.Text(
              skill,
              style: const pw.TextStyle(fontSize: 9),
            ),
          )).toList(),
        ),
      ],
    );
  }
  
  static pw.Widget _buildEducation(ResumeData resume) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Education'),
        pw.SizedBox(height: 8),
        ...resume.education.map((edu) => pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      edu.degree,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      edu.school,
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              pw.Text(
                edu.year,
                style: const pw.TextStyle(fontSize: 10),
              ),
            ],
          ),
        )),
      ],
    );
  }
  
  static pw.Widget _buildSectionTitle(String title) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 4),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(color: PdfColors.blue, width: 2),
        ),
      ),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.blue,
        ),
      ),
    );
  }
}
