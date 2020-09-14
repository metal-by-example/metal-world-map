
import UIKit
import Metal
import MetalKit
import ARKit

class ViewController: UIViewController, MTKViewDelegate, ARSessionDelegate {
    
    var session: ARSession!
    var renderer: Renderer!
    
    var mtkView: MTKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        session = ARSession()
        session.delegate = self
        
        mtkView = view as? MTKView

        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.backgroundColor = .black
        mtkView.delegate = self

        renderer = Renderer(session: session, view: mtkView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .mesh

        session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.pause()
    }

    // MARK: - MTKViewDelegate

    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }

    func draw(in view: MTKView) {
        renderer.update()
    }
}
