import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/services/resume_models.dart';
import 'resume_pdf_builder.dart';

class ResumeDownload {
  static Future<void> downloadGenerated(BuildContext context, ResumeData resume) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Generating PDF...')),
      );
      
      final pdfBytes = await ResumePdfBuilder.generatePdf(resume);
      
      if (kIsWeb) {
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', '${resume.fullName.replaceAll(' ', '_')}_Resume.pdf')
          ..click();
        html.Url.revokeObjectUrl(url);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Resume downloaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating PDF: $e')),
      );
    }
  }
  
  static void downloadStatic(BuildContext context) {
    if (kIsWeb) {
      final anchor = html.AnchorElement(href: 'resume.pdf')
        ..setAttribute('download', 'Oladipo_Danmusa_Resume.pdf')
        ..click();
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Static resume downloaded!')),
      );
    }
  }
}
