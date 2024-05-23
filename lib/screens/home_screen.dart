import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LoadGltfOrGlbFilePage extends StatefulWidget {
  const LoadGltfOrGlbFilePage({super.key});

  @override
  State<LoadGltfOrGlbFilePage> createState() => _LoadGltfOrGlbFilePageState();
}

class _LoadGltfOrGlbFilePageState extends State<LoadGltfOrGlbFilePage> {
  late ARKitController arkitController;
  int _modelIndex = 0;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Load .gltf or .glb')),
        body: ARKitSceneView(
          showFeaturePoints: true,
          enableTapRecognizer: true,
          planeDetection: ARPlaneDetection.horizontalAndVertical,
          onARKitViewCreated: onARKitViewCreated,
        ),
      );

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    final node = _getNodeFromFlutterAsset(position);

    arkitController.add(node);
  }

  ARKitGltfNode _getNodeFromFlutterAsset(vector.Vector3 position) {
    String url;
    switch (_modelIndex) {
      case 0:
        url = 'assets/t-rex_jurassic_park/scene.gltf';
        break;
      case 1:
        url = 'assets/ikran_avatar/scene.gltf';
        break;
      case 2:
        url = 'assets/brachiosaurus-altithorax/source/Brachi/Brachiosaurus.gltf';
        break;
      case 3:
        url = 'assets/pliosaur/scene.gltf';
        break;
      default:
        url = 'assets/t-rex_jurassic_park/scene.gltf';
    }

    _modelIndex = (_modelIndex + 1) % 3; // Increment index and wrap around

    return ARKitGltfNode(
      assetType: AssetType.flutterAsset,
      url: url,
      scale: vector.Vector3(0.05, 0.05, 0.05),
      position: position,
    );
  }
}
