import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/entities/company.dart';
import '../providers/company_provider.dart';
import '../../data/repositories/company_repository.dart';
import '../../../../core/widgets/phone_number_link.dart';

/// Sort option for dropdown
enum SortOption {
  nameAsc('А-Я ↑', CompanySortField.name, SortDirection.ascending),
  nameDesc('А-Я ↓', CompanySortField.name, SortDirection.descending),
  lastContactDesc('Посл. контакт ↓', CompanySortField.lastContactDate, SortDirection.descending),
  lastContactAsc('Посл. контакт ↑', CompanySortField.lastContactDate, SortDirection.ascending);

  final String label;
  final CompanySortField field;
  final SortDirection direction;

  const SortOption(this.label, this.field, this.direction);

  static SortOption fromFieldAndDirection(CompanySortField field, SortDirection direction) {
    return SortOption.values.firstWhere(
      (option) => option.field == field && option.direction == direction,
      orElse: () => SortOption.nameAsc,
    );
  }
}

/// Companies list page
///
/// Main screen showing all companies with search, filter, and sort functionality.
class CompaniesListPage extends StatefulWidget {
  const CompaniesListPage({super.key});

  @override
  State<CompaniesListPage> createState() => _CompaniesListPageState();
}

class _CompaniesListPageState extends State<CompaniesListPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    // Load companies on first open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final companyProvider = Provider.of<CompanyProvider?>(context, listen: false);
      companyProvider?.loadCompanies();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });

    final companyProvider = Provider.of<CompanyProvider?>(context, listen: false);
    companyProvider?.searchCompanies(query);
  }

  Future<void> _handleRefresh() async {
    final companyProvider = Provider.of<CompanyProvider?>(context, listen: false);
    await companyProvider?.refreshCompanies();
  }

  Future<void> _handleDelete(Company company) async {
    final companyProvider = Provider.of<CompanyProvider?>(context, listen: false);

    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удалить компанию?'),
        content: Text(
          'Вы действительно хотите удалить компанию "${company.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFF53178),
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      await companyProvider?.deleteCompany(company.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Компания удалена')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: const Color(0xFFF53178),
          ),
        );
      }
    }
  }

  Color _getStatusColor(CompanyStatus status) {
    switch (status) {
      case CompanyStatus.real:
        return const Color(0xFF00C48C);
      case CompanyStatus.potential:
        return const Color(0xFF006FFD);
      case CompanyStatus.lost:
        return const Color(0xFFF53178);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final companyProvider = Provider.of<CompanyProvider?>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Компании'),
        leading: authProvider.isAdmin
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        actions: [
          // Stats badge
          if (companyProvider != null)
            Consumer<CompanyProvider>(
              builder: (context, provider, _) {
                final total = provider.companyStats['total'] ?? 0;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF006FFD).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Всего: $total',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF006FFD),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: companyProvider == null
          ? const Center(
              child: Text('Провайдер компаний не инициализирован'),
            )
          : Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _handleSearch,
                    decoration: InputDecoration(
                      hintText: 'Поиск по названию, телефону или адресу',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _handleSearch('');
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFFC5C6CC),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF006FFD),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),

                // Status filter and Sort dropdown row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // Status filter
                      const Text(
                        'Статус:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Consumer<CompanyProvider>(
                          builder: (context, provider, _) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFC5C6CC),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<CompanyStatus?>(
                                value: provider.statusFilter,
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                ),
                                hint: const Text(
                                  'Все',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                                items: [
                                  const DropdownMenuItem<CompanyStatus?>(
                                    value: null,
                                    child: Text(
                                      'Все',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                  DropdownMenuItem<CompanyStatus?>(
                                    value: CompanyStatus.real,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF00C48C),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Flexible(
                                          child: Text(
                                            'Реальный',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Inter',
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<CompanyStatus?>(
                                    value: CompanyStatus.potential,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF006FFD),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Flexible(
                                          child: Text(
                                            'Потенциальный',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Inter',
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<CompanyStatus?>(
                                    value: CompanyStatus.lost,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF53178),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Flexible(
                                          child: Text(
                                            'Потерянный',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Inter',
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                onChanged: (CompanyStatus? newValue) {
                                  if (newValue == null) {
                                    provider.clearStatusFilter();
                                  } else {
                                    provider.setStatusFilter(newValue);
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Sort dropdown
                      const Text(
                        'Сортировка:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Consumer<CompanyProvider>(
                          builder: (context, provider, _) {
                            final currentOption = SortOption.fromFieldAndDirection(
                              provider.sortField,
                              provider.sortDirection,
                            );

                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFFC5C6CC),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<SortOption>(
                                value: currentOption,
                                isExpanded: true,
                                underline: const SizedBox.shrink(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                  color: Colors.black,
                                ),
                                items: SortOption.values.map((option) {
                                  return DropdownMenuItem<SortOption>(
                                    value: option,
                                    child: Text(
                                      option.label,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (SortOption? newValue) {
                                  if (newValue != null) {
                                    provider.setSorting(
                                      newValue.field,
                                      newValue.direction,
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Companies list
                Expanded(
                  child: Consumer<CompanyProvider>(
                    builder: (context, provider, _) {
                      if (provider.isLoading && provider.companies.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (provider.hasError && provider.companies.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Color(0xFFF53178),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                provider.errorMessage ?? 'Ошибка загрузки',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF8F9098),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () => provider.loadCompanies(),
                                child: const Text('Повторить'),
                              ),
                            ],
                          ),
                        );
                      }

                      if (provider.companies.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.business_outlined,
                                size: 64,
                                color: Color(0xFF8F9098),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Компаний нет',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Sora',
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Нажмите + чтобы добавить',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF8F9098),
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: _handleRefresh,
                        child: ListView.builder(
                          itemCount: provider.companies.length,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            final company = provider.companies[index];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: InkWell(
                                onTap: () {
                                  context.go('/companies/${company.id}');
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              company.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(company.status)
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              company.status.displayName,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor(
                                                    company.status),
                                              ),
                                            ),
                                          ),
                                          PopupMenuButton<String>(
                                            icon: const Icon(Icons.more_vert),
                                            onSelected: (value) {
                                              if (value == 'edit') {
                                                context.go(
                                                    '/companies/${company.id}/edit');
                                              } else if (value == 'delete') {
                                                _handleDelete(company);
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem(
                                                value: 'edit',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.edit, size: 20),
                                                    SizedBox(width: 8),
                                                    Text('Редактировать'),
                                                  ],
                                                ),
                                              ),
                                              const PopupMenuItem(
                                                value: 'delete',
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete, size: 20),
                                                    SizedBox(width: 8),
                                                    Text('Удалить'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      PhoneNumberLink(
                                        phoneNumber: company.phone,
                                        icon: Icons.phone,
                                        iconSize: 14,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF006FFD),
                                          decoration: TextDecoration.underline,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: Color(0xFF8F9098),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              company.address,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF8F9098),
                                                fontFamily: 'Inter',
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (company.lastContactDate != null) ...[
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Color(0xFF8F9098),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Последний контакт: ${_formatDate(company.lastContactDate!)}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF8F9098),
                                                fontFamily: 'Inter',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/companies/create'),
        backgroundColor: const Color(0xFF006FFD),
        child: const Icon(Icons.add),
      ),
      drawer: authProvider.isAdmin
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFF006FFD),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 28,
                            color: Color(0xFF006FFD),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          authProvider.currentUser?.fullName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          authProvider.currentUser?.email ?? '',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            fontFamily: 'Inter',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.business),
                    title: const Text('Компании'),
                    selected: true,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  if (authProvider.isAdmin)
                    ListTile(
                      leading: const Icon(Icons.people),
                      title: const Text('Управление пользователями'),
                      onTap: () {
                        Navigator.pop(context);
                        context.go('/users');
                      },
                    ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Выйти'),
                    onTap: () async {
                      await authProvider.logout();
                      if (context.mounted) {
                        context.go('/login');
                      }
                    },
                  ),
                ],
              ),
            )
          : null,
    );
  }

  String _formatDate(DateTime date) {
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    return dateFormat.format(date);
  }
}
