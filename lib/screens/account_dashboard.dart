import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../widgets/union_page_scaffold.dart';

class AccountDashboard extends StatelessWidget {
  const AccountDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return UnionPageScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'My Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4d2963),
                  ),
                ),
                const SizedBox(height: 32),

                // Profile Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: const Color(0xFF4d2963),
                          backgroundImage: user.photoUrl != null
                              ? NetworkImage(user.photoUrl!)
                              : null,
                          child: user.photoUrl == null
                              ? Text(
                                  user.initials,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.displayName ?? 'User',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                user.email,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              if (user.phoneNumber != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  user.phoneNumber!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/profile-settings');
                          },
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit Profile',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Dashboard Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 500 ? 2 : 1);
                    
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.5,
                      children: [
                        _DashboardCard(
                          icon: Icons.shopping_bag,
                          title: 'Orders',
                          subtitle: '${user.orderHistory.length} orders',
                          color: Colors.blue,
                          onTap: () {
                            Navigator.pushNamed(context, '/order-history');
                          },
                        ),
                        _DashboardCard(
                          icon: Icons.settings,
                          title: 'Settings',
                          subtitle: 'Account preferences',
                          color: Colors.orange,
                          onTap: () {
                            Navigator.pushNamed(context, '/profile-settings');
                          },
                        ),
                        _DashboardCard(
                          icon: Icons.favorite,
                          title: 'Wishlist',
                          subtitle: 'Coming soon',
                          color: Colors.red,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Wishlist coming soon!')),
                            );
                          },
                        ),
                        _DashboardCard(
                          icon: Icons.location_on,
                          title: 'Addresses',
                          subtitle: 'Manage shipping',
                          color: Colors.green,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Address management coming soon!')),
                            );
                          },
                        ),
                        _DashboardCard(
                          icon: Icons.payment,
                          title: 'Payment',
                          subtitle: 'Payment methods',
                          color: Colors.purple,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Payment management coming soon!')),
                            );
                          },
                        ),
                        _DashboardCard(
                          icon: Icons.help,
                          title: 'Help',
                          subtitle: 'Support & FAQ',
                          color: Colors.teal,
                          onTap: () {
                            Navigator.pushNamed(context, '/about');
                          },
                        ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 32),

                // Sign Out Button
                Center(
                  child: SizedBox(
                    width: 200,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Sign Out'),
                            content: const Text('Are you sure you want to sign out?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Sign Out'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && context.mounted) {
                          await authService.signOut();
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, '/');
                          }
                        }
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
