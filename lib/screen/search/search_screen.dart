import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  static String routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Course> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
      // Ici, vous pouvez implémenter la logique de recherche réelle
      _searchResults = []; // Remplacer par la vraie recherche
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.colorTint700),
                  onPressed: () => Navigator.pop(context),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.colorTint200,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Rechercher un cours...',
                        hintStyle: const TextStyle(
                          
                          color: AppColors.colorTint500,
                          fontSize: 14,
                        ),
                        contentPadding:EdgeInsets.only(top: 8),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            'assets/icons/search.svg',
                            color: AppColors.colorTint500,
                          ),
                        ),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: AppColors.colorTint500),
                                onPressed: () {
                                  _searchController.clear();
                                  _handleSearch('');
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onChanged: _handleSearch,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _isSearching && _searchResults.isEmpty
          ? const Center(
              child: Text(
                'Aucun résultat trouvé',
                style: TextStyle(
                  color: AppColors.colorTint500,
                  fontSize: 16,
                ),
              ),
            )
          : !_isSearching
              ? _buildSuggestedSearches()
              : _buildSearchResults(),
    );
  }

  Widget _buildSuggestedSearches() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recherches populaires',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.colorTint700,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Flutter',
              'React Native',
              'UI/UX Design',
              'JavaScript',
              'Python',
              'Machine Learning',
            ].map((tag) => _buildSearchTag(tag)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTag(String tag) {
    return InkWell(
      onTap: () {
        _searchController.text = tag;
        _handleSearch(tag);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.colorTint200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          tag,
          style: const TextStyle(
            color: AppColors.colorTint700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final course = _searchResults[index];
        return ListTile(
          // Implémenter l'affichage des résultats de recherche
          title: Text(course.title ?? ''),
          subtitle: Text(course.teacherName ?? ''),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(course.courseImage ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          onTap: () {
            // Navigation vers le détail du cours
          },
        );
      },
    );
  }
} 