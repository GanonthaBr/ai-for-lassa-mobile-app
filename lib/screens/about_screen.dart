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
                'AI4Lassa leverages artificial intelligence to assist in early detection and risk assessment of Lassa fever.',
                'Our system analyzes symptoms and environmental factors to provide preliminary risk assessments.',
                'The app serves as a screening tool to help healthcare workers and individuals identify potential cases.',
                'This technology aims to improve surveillance and early intervention in Lassa fever endemic regions.',
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
        'icon': Icons.assignment_turned_in,
        'title': 'Symptom Reporting',
        'desc': 'Quick and comprehensive symptom assessment',
      },
      {
        'icon': Icons.thermostat,
        'title': 'Environmental Data',
        'desc': 'Temperature and humidity monitoring',
      },
      {
        'icon': Icons.analytics,
        'title': 'AI Risk Assessment',
        'desc': 'Machine learning-powered risk evaluation',
      },
      {
        'icon': Icons.bar_chart,
        'title': 'Data Insights',
        'desc': 'Statistical analysis and trends',
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
                      size: 25,
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
