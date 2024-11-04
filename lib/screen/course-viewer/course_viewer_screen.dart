import 'package:coursenligne/config/theme/theme.dart';
import 'package:coursenligne/model/model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CourseViewerScreen extends StatefulWidget {
  static String routeName = '/course-viewer';
  final Course course;
  final int initialLessonIndex;

  const CourseViewerScreen({
    Key? key,
    required this.course,
    this.initialLessonIndex = 0,
  }) : super(key: key);

  @override
  State<CourseViewerScreen> createState() => _CourseViewerScreenState();
}

class _CourseViewerScreenState extends State<CourseViewerScreen> {
  late VideoPlayerController _controller;
  late int _currentLessonIndex;
  bool _isFullScreen = false;
  bool _isInitialized = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _currentLessonIndex = widget.initialLessonIndex;
    _initializeVideo();
  }

  void _initializeVideo() {
    setState(() {
      _isInitialized = false;
      _isError = false;
    });

    try {
      // URL de test pour la vidéo
      _controller = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      )..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
        }
      }).catchError((error) {
        if (mounted) {
          setState(() {
            _isError = true;
          });
        }
        print('Erreur d\'initialisation de la vidéo: $error');
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isError = true;
        });
      }
      print('Erreur lors de la création du contrôleur: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFullScreen) {
      return _buildVideoPlayer();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.colorTint700),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.course.title ?? 'Cours',
          style: const TextStyle(
            color: AppColors.colorTint700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (_isError)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.white,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _initializeVideo,
                            child: const Text('Réessayer'),
                          ),
                        ],
                      ),
                    )
                  else if (!_isInitialized)
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.colorPrimary,
                      ),
                    )
                  else
                    _buildVideoPlayer(),
                  if (_isInitialized && !_isError)
                    _buildVideoControls(),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLessonInfo(),
                    _buildLessonsList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        });
      },
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }

  Widget _buildVideoControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.transparent,
            ],
          ),
        ),
        child: Column(
          children: [
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: AppColors.colorPrimary,
                bufferedColor: Colors.white24,
                backgroundColor: Colors.white12,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });
                  },
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: _toggleFullScreen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonInfo() {
    final currentLesson = widget.course.lessons?[_currentLessonIndex];
    if (currentLesson == null) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentLesson.lessonName ?? '',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.colorTint700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.colorTint500,
              ),
              const SizedBox(width: 4),
              Text(
                'Durée: ${currentLesson.lessonDuration}',
                style: const TextStyle(
                  color: AppColors.colorTint500,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
        ],
      ),
    );
  }

  Widget _buildLessonsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.course.lessons?.length ?? 0,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final lesson = widget.course.lessons?[index];
        if (lesson == null) return const SizedBox();

        final isCurrentLesson = _currentLessonIndex == index;

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          leading: CircleAvatar(
            backgroundColor: isCurrentLesson
                ? AppColors.colorPrimary
                : AppColors.colorTint200,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isCurrentLesson ? Colors.white : AppColors.colorTint700,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            lesson.lessonName ?? '',
            style: TextStyle(
              fontWeight: isCurrentLesson ? FontWeight.bold : FontWeight.normal,
              color: isCurrentLesson ? AppColors.colorPrimary : AppColors.colorTint700,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              lesson.lessonDuration ?? '',
              style: TextStyle(
                color: isCurrentLesson ? AppColors.colorPrimary.withOpacity(0.7) : AppColors.colorTint500,
              ),
            ),
          ),
          onTap: () {
            setState(() {
              _currentLessonIndex = index;
              _initializeVideo();
            });
          },
        );
      },
    );
  }
} 