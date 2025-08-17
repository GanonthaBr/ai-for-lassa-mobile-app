import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('About AI4Lassa'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            _buildHeaderSection(),
            const SizedBox(height: AppConstants.largePadding),

            // About Lassa Fever Section
            _buildInfoSection(
              title: 'About Lassa Fever',
              icon: Icons.info_outline,
              color: AppConstants.warningColor,
              content: [
                'Lassa fever is a viral hemorrhagic fever endemic to West Africa, particularly Nigeria, Sierra Leone, Guinea, and Liberia.',
                'The disease is transmitted to humans primarily through contact with rodents (Mastomys natalensis) or contaminated materials.',
                'An estimated 100,000-300,000 people are infected annually, with case fatality rates of 10-20% in hospitalized patients.',
                'Early diagnosis and treatment are crucial for improving outcomes and preventing spread.',
              ],
            ),

            const SizedBox(height: AppConstants.largePadding),

            // About AI4Lassa Section
            _buildInfoSection(
              title: 'About AI4Lassa',
              icon: Icons.psychology,
              color: AppConstants.primaryColor,
              content: [
                'The Development of an AI solution User Application to Raise Early Alarm to Improve Urban Health awareness, preparedness and Quick Response to Lassa Fever Outbreaks Project (AI4Lassa) is a project funded by the Tertiary Education Trust Fund (TETFUND) under the National Research Fund (NRF) in 2024.',
                'AI4Lassa is a pioneering initiative developed to address the persistent challenge of Lassa fever outbreaks in Nigeria through the power of artificial intelligence (AI). Our solution focuses on enhancing early detection capabilities, enabling rapid response, and fostering community health awareness. With a targeted approach, AI4Lassa seeks to revolutionize Nigeria’s healthcare infrastructure by empowering public health stakeholders and communities to respond more effectively to health crises. This project stands as a significant public health milestone and invites collaboration and support to ensure sustainable and successful implementation.',
                '\nOur Vision',
                'AI4Lassa envisions a future where Lassa fever and similar outbreaks can be detected and controlled promptly, reducing their socio-economic impact and contributing to a healthier and safer Nigeria and West Africa.',
                '\nObjectives',
                'Early Detection: Develop an AI-driven application capable of identifying early signs of Lassa fever outbreaks by analyzing real-time data and accurately localizing affected areas.',
                'Stakeholder Alerts: Implement an automated alert system to notify public health authorities, providing detailed and timely information for swift intervention.',
                'Outbreak Monitoring and Recommendations: Continuously monitor outbreak progression and advise on control measures, including isolation and treatment protocols.',
                'Public Awareness: Offer guidance to the public on preventive measures, emphasizing personal hygiene and food safety.',
                'Resource Allocation: Facilitate the efficient distribution of medical supplies and personnel to affected regions, ensuring swift and organized response.',
                '\nResearch Framework',
                'Our research is designed to answer key questions in the application of AI for health crisis management:',
                'How can AI identify early warning signs of Lassa fever outbreaks?',
                'What data sources are essential for early detection?',
                'Which machine learning and natural language processing techniques are best suited for outbreak prediction?',
                'How can AI4Lassa be optimized for usability by stakeholders?',
                'What ethical and legal considerations should be prioritized?',
                'How can potential limitations of AI4Lassa be effectively mitigated?',
                '\nResearch Outputs and Outcomes',
                'AI4Lassa is dedicated to advancing AI-based public health initiatives with the following expected outcomes:',
                'Enhanced collaboration with governmental and research institutions to establish impactful policies.',
                'Development of a comprehensive application connecting public sector institutions across Nigeria.',
                'Establishment of state-of-the-art AI laboratories at FUTMinna to operate as data hubs.',
                'Ensured access to clean, reliable data from verified sources, supporting data integrity and accessibility.',
                'A dedicated website enabling seamless data access and inter-university data sharing.',
                'Creation of mentoring opportunities within AI disciplines for Nigerian students.',
                'Promotion of synergy between government, industry, and academia through collaborative programs.',
                'Encouragement of stakeholder engagement and data center ownership.',
                'Strengthening Nigeria’s national development through resource sharing and alliance-building.',
                '\nProject Impact',
                'Beyond enhancing response times, AI4Lassa has the potential to reshape several key areas:',
                'Cybersecurity: Secure and accurate data safeguards the health sector from potential cyber vulnerabilities.',
                'Economic Development: Effective resource allocation ensures cost efficiency, enhancing overall productivity.',
                'Health Access and SDG Alignment: Facilitates equitable health responses, especially in underserved regions, contributing to Sustainable Development Goal 3 (Good Health and Well-Being).',
                'Industrial Growth and Job Creation: A healthy workforce is fundamental to economic stability and growth.',
                'Educational Development: The AI4Lassa framework supports research and education on Lassa fever, providing invaluable resources for academic and community awareness.',
                'In collaboration with the Nigerian health sector, public institutions, academic entities, and other stakeholders, AI4Lassa is committed to developing reliable, efficient, and responsive systems for epidemic alerts and intervention. Through these efforts, we aim to significantly enhance Nigeria’s public health resilience, enabling a proactive and well-prepared approach to epidemic management.',
                '\nOur Team',
                'Our team is made up of dedicated researchers, developers, and public health experts from the Federal University of Technology Minna (FUTMinna) and partner institutions. Together, we bring diverse expertise in artificial intelligence, epidemiology, software development, and public health policy to tackle the challenges of Lassa fever surveillance and control.',
                'Learn more: https://ai4lassa.vercel.app/about',
              ],
            ),

            const SizedBox(height: AppConstants.largePadding),

            // Key Features Section
            _buildFeaturesSection(),

            const SizedBox(height: AppConstants.largePadding),

            // Important Notice
            // _buildNoticeSection(),

            // const SizedBox(height: AppConstants.largePadding),

            // App Information
            // _buildAppInfoSection(),

            // const SizedBox(height: AppConstants.largePadding),

            // Resources Section
            _buildResourcesSection(),

            const SizedBox(height: AppConstants.largePadding),

            // Team Section
            _buildTeamSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConstants.primaryColor,
            AppConstants.primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
      ),
      child: Column(
        children: [
          Icon(Icons.medical_services, color: Colors.white, size: 64),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            AppConstants.appName,
            style: AppConstants.titleStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'AI-Powered Lassa Fever Detection & Risk Assessment',
            style: AppConstants.bodyStyle.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<String> content,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.smallPadding),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: AppConstants.smallPadding),
              Text(
                title,
                style: AppConstants.subtitleStyle.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          ...content
              .map(
                (text) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppConstants.smallPadding,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppConstants.smallPadding),
                      Expanded(
                        child: Text(
                          text,
                          style: AppConstants.bodyStyle,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    final features = [
      {
        'icon': Icons.analytics,
        'title': 'AI Risk Assessment',
        'desc': 'Machine learning-powered risk evaluation',
      },
      {
        'icon': Icons.timeline,
        'title': 'Outbreak Forecasting',
        'desc':
            'Our advanced algorithms predict potential LASSA fever outbreaks based on real-time data',
      },
      {
        'icon': Icons.report,
        'title': 'Case Reporting',
        'desc':
            'Suspect a case? Easily report it to health officials through our secure platform. Q',
      },
      {
        'icon': Icons.notifications_active,
        'title': 'Real-time Alerts',
        'desc':
            'Receive immediate alerts on outbreaks in your area to stay safe and informed',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(AppConstants.smallPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star_outline, color: AppConstants.secondaryColor),
              const SizedBox(width: AppConstants.smallPadding),
              Text(
                'Key Features',
                style: AppConstants.subtitleStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.smallPadding),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: AppConstants.smallPadding,
              mainAxisSpacing: AppConstants.smallPadding,
            ),
            itemCount: features.length,
            itemBuilder: (context, index) {
              final feature = features[index];
              return Container(
                padding: const EdgeInsets.all(AppConstants.smallPadding),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonRadius,
                  ),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      feature['icon'] as IconData,
                      color: AppConstants.primaryColor,
                      size: 16,
                    ),
                    const SizedBox(height: AppConstants.smallPadding),
                    Text(
                      feature['title'] as String,
                      style: AppConstants.bodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      feature['desc'] as String,
                      style: AppConstants.captionStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppConstants.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: AppConstants.warningColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning, color: AppConstants.warningColor, size: 24),
              const SizedBox(width: AppConstants.smallPadding),
              Text(
                'Important Notice',
                style: AppConstants.bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppConstants.warningColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'This app is a screening tool and should not replace professional medical diagnosis. Always consult qualified healthcare providers for proper medical evaluation and treatment.',
            style: AppConstants.bodyStyle.copyWith(
              color: AppConstants.warningColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'App Information',
            style: AppConstants.subtitleStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          _buildInfoRow('Version', AppConstants.appVersion),
          _buildInfoRow('Platform', 'Flutter/Dart'),
          _buildInfoRow('Target Region', 'West Africa'),
          _buildInfoRow('Last Updated', 'January 2025'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppConstants.bodyStyle),
          Text(
            value,
            style: AppConstants.bodyStyle.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildResourcesSection() {
    final resources = [
      {
        'title': 'WHO Lassa Fever Fact Sheet',
        'url': 'https://www.who.int/news-room/fact-sheets/detail/lassa-fever',
      },
      {
        'title': 'CDC Lassa Fever Information',
        'url': 'https://www.cdc.gov/vhf/lassa/',
      },
      {
        'title': 'ISARIC Lassa Resources',
        'url': 'https://isaric.org/research/lassa-fever-resources/',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Resources',
            style: AppConstants.subtitleStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          ...resources
              .map(
                (resource) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.link, color: AppConstants.primaryColor),
                  title: Text(
                    resource['title']!,
                    style: AppConstants.bodyStyle.copyWith(
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  onTap: () => _launchUrl(resource['url']!),
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Development Team',
            style: AppConstants.subtitleStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Developed by a dedicated team of researchers, healthcare professionals, and software engineers committed to improving public health outcomes in West Africa.',
            style: AppConstants.bodyStyle,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'For technical support or collaboration inquiries, please use the Contact section.',
            style: AppConstants.captionStyle,
          ),
          //our website
          Row(
            children: [
              Text(
                'Visit our website: ',
                style: AppConstants.bodyStyle,
                textAlign: TextAlign.justify,
              ),
              GestureDetector(
                onTap: () => _launchUrl('https://ai4lassa.vercel.app/'),
                child: Text(
                  'www.ai4lassa.app',
                  style: AppConstants.captionStyle.copyWith(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
