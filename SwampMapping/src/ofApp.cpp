#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup()
{
	ofSetLogLevel(OF_LOG_NOTICE);
	ofDisableArbTex();
	ofBackground(ofColor::black);

    //load text imgs
	ofImage image;
	image.setUseTexture(false);
	if (!image.load("testcard.png"))
	{
		ofLogError("ofApp::setup") << "Could not load image!";
		return;
	}
    testTexture.enableMipmap();
    testTexture.loadData(image.getPixels());
    
    mClientFbo.allocate(1200, 1200, GL_RGBA);
    mClientFbo.begin();
    ofClear(255,255,255,255);
    mClientFbo.end();

	// Load warp settings from file if one exists.
	this->warpController.loadSettings("settings.json");
	if (this->warpController.getWarps().empty())
	{
		// Otherwise create warps from scratch.
		std::shared_ptr<ofxWarpBase> warp; 
		
		warp = this->warpController.buildWarp<ofxWarpPerspectiveBilinear>();
		warp->setSize(1200, 1200);
        warp->setEdges(glm::vec4(0.0f, 0.0f, 0.0f, 0.0f));
        warp->setBrightness(1.0);
        warp->setGamma(1.0);
        warp->setExponent(2.0);
        warp->setLuminance(0.5);
    }else{
        for (auto i = 0; i < this->warpController.getNumWarps(); ++i){
            auto warp = this->warpController.getWarp(i);
            warp->setSize(1200, 1200);
        }
    }
    
	
    //load syphon client
    mClient.setup();
    //using Syphon app Simple Server, found at http://syphon.v002.info/
    mClient.set("Swamp","CreaturesSwamp");
    
    toggleGUI = false;
}

//--------------------------------------------------------------
void ofApp::exit()
{
	this->warpController.saveSettings("settings.json");
}

//--------------------------------------------------------------
void ofApp::update()
{
    
    
}

//--------------------------------------------------------------
void ofApp::draw()
{
 
	ofBackground(ofColor::black);
    
    mClientFbo.begin();
    mClient.draw(0, 0, 1200, 1200);
    mClientFbo.end();

    for (auto i = 0; i < this->warpController.getNumWarps(); ++i)
    {
        auto warp = this->warpController.getWarp(i);
        ofSetColor(255);
        warp->draw( mClientFbo.getTexture());
    }
	


    //debuf values
    if(toggleGUI){
        mClient.draw(0, 0, 200, 200);
        std::ostringstream oss;
        oss << ofToString(ofGetFrameRate(), 2) << " fps" << endl;
        oss << "[w]arp edit: " << (this->warpController.getWarp(0)->isEditing() ? "on" : "off");
        ofSetColor(ofColor::white);
        ofDrawBitmapStringHighlight(oss.str(), 10, 20);
    }
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key)
{
	if (key == 'f'){
		ofToggleFullscreen();
	}
	else if (key == 'g'){
        toggleGUI = !toggleGUI;
	}
	else if (key == 'd'){
		
	}
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
