<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Untact Gallery</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
<!-- <link type="text/css" rel="stylesheet" href="main.css"> -->
<style>
@font-face {
	font-family: 'NEXON Lv1 Gothic OTF';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: 'NEXON Lv1 Gothic OTF';
}

#blocker {
	position: absolute;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
}

#instructions {
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	font-size: 14px;
	cursor: pointer;
}

.btn {
	display: block;
	float:right;
	width: 150px;
	height: 50px;
	line-height: 40px;
	border: 1px white solid;
	border-radius:5px;
	margin: 5px auto;
	 margin-right: 15px;
	background-color: black;
	text-align: center;
	font-size: 17px;
	cursor: pointer;
	color: white;
	transition: all 0.9s, color 0.2;
}

.btn:hover {
	box-shadow:200px 0 0 0 rgba(255,255,255,0.5) inset;
}
</style>
</head>
<body>
	<script type="module">

			import * as THREE from '<c:url value='/resources/libs/three.module.js' />';
			import { GLTFLoader } from '<c:url value='/resources/libs/GLTFLoader.js' />';
			import { PointerLockControls } from '<c:url value='/resources/jsm/controls/PointerLockControls.js' />';

			var camera, scene, renderer, controls, mouse, SELECTED;

			const objects = [];

			let raycaster;
			let cameraDirection = new THREE.Vector3();

			let moveForward = false;
			let moveBackward = false;
			let moveLeft = false;
			let moveRight = false;

			let prevTime = performance.now();
			const velocity = new THREE.Vector3();
			const direction = new THREE.Vector3();
			const vertex = new THREE.Vector3();
			const color = new THREE.Color();

			let imgUrl = "../resources/img/7.png";
			let artworkId = 7;
			const s3_url = "https://webvrbucket.s3.ap-northeast-2.amazonaws.com/exhibition/${exhibitionId}/";

			init();
			animate();

			function init() {
				//Ã¬Â¹Â´Ã«Â©ÂÃ«ÂÂ¼ + Ã¬ÂÂ¬ + ÃªÂ´ÂÃ¬ÂÂ Ã¬Â´ÂÃªÂ¸Â° Ã¬ÂÂ¤Ã¬Â Â
				camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 1, 1000 );
				camera.position.x = 90;
				camera.position.y = 30;
				camera.position.z = 60;
				camera.rotation.y = Math.PI / 2;
				camera.zoom = 1;

				scene = new THREE.Scene();
				scene.background = new THREE.Color( 0xffffff );
				scene.fog = new THREE.Fog( 0xffffff, 0, 750 );

				const light = new THREE.HemisphereLight( 0xeeeeff, 0x777788, 0.75 );
				light.position.set( 0.5, 1, 0.75 );
				scene.add( light );

				//PointerLockControls Ã¬Â´ÂÃªÂ¸Â°Ã­ÂÂ Ã¬ÂÂ¤Ã¬Â Â
				controls = new PointerLockControls( camera, document.body );

				const blocker = document.getElementById( 'blocker' );
				const instructions = document.getElementById( 'instructions' );

				//Ã¬Â²ÂÃ¬ÂÂ Ã¬ÂÂ¤Ã­ÂÂ + EscÃ«Â¡Â Ã¬ÂÂ¼Ã¬ÂÂÃ¬Â ÂÃ¬Â§Â + Ã«Â¸ÂÃ«ÂÂ¼Ã¬ÂÂ°Ã¬Â Â Ã«Â°ÂÃªÂ¹Â¥Ã¬ÂÂ¼Ã«Â¡Â Ã«Â²ÂÃ¬ÂÂ´Ã«ÂÂ¬Ã¬ÂÂ Ã«ÂÂ Ã«ÂÂÃ¬ÂÂ°Ã«ÂÂ Ã¬ÂÂÃ«ÂÂ´Ã«Â¬Â¸ Ã¬ÂÂ´Ã«Â²Â¤Ã­ÂÂ¸
				instructions.addEventListener( 'click', function () {
					controls.lock();
				} );

				//Ã¬ÂÂÃ«ÂÂ´Ã«Â¬Â¸ Ã­ÂÂ´Ã«Â¦Â­ Ã¬ÂÂ Ã¬ÂÂ¬Ã«ÂÂ¼Ã¬Â¡ÂÃ«ÂÂ¤ÃªÂ°Â, Ã¬ÂÂÃ«ÂÂÃ«Â©Â´ Ã«ÂÂ¤Ã¬ÂÂ Ã«ÂÂÃ­ÂÂÃ«ÂÂ¨
				controls.addEventListener( 'lock', function () {
					instructions.style.display = 'none';
					blocker.style.display = 'none';
					console.log("lock");
				} );
				controls.addEventListener( 'unlock', function () {
					blocker.style.display = 'block';
					instructions.style.display = '';
				} );

				scene.add( controls.getObject() );

				//Ã­ÂÂ¤(w, a, s, d, space bar, Ã­ÂÂÃ¬ÂÂ´Ã­ÂÂ)Ã«Â¥Â¼ Ã«ÂÂÃ«Â ÂÃ¬ÂÂ Ã«ÂÂÃ¬ÂÂ Ã¬ÂÂ´Ã«Â²Â¤Ã­ÂÂ¸
				const onKeyDown = function ( event ) {

					switch ( event.code ) {

						case 'ArrowUp':
						case 'KeyW':
							moveForward = true;
							break;

						case 'ArrowLeft':
						case 'KeyA':
							moveLeft = true;
							break;

						case 'ArrowDown':
						case 'KeyS':
							moveBackward = true;
							break;

						case 'ArrowRight':
						case 'KeyD':
							moveRight = true;
							break;

						case 'KeyF':
							console.log("keyffff");
							// onMouseClick();
							break;

					}

				};

				//Ã­ÂÂ¤Ã¬ÂÂÃ¬ÂÂ Ã«ÂÂÃ¬ÂÂ Ã«ÂÂÃ¬ÂÂ Ã¬ÂÂ´Ã«Â²Â¤Ã­ÂÂ¸
				const onKeyUp = function ( event ) {

					switch ( event.code ) {

						case 'ArrowUp':
						case 'KeyW':
							moveForward = false;
							break;

						case 'ArrowLeft':
						case 'KeyA':
							moveLeft = false;
							break;

						case 'ArrowDown':
						case 'KeyS':
							moveBackward = false;
							break;

						case 'ArrowRight':
						case 'KeyD':
							moveRight = false;
							break;

					}

				};

				document.addEventListener( 'keydown', onKeyDown );
				document.addEventListener( 'keyup', onKeyUp );


				//******************************************************

				//Ã«Â ÂÃ¬ÂÂ´Ã¬ÂºÂÃ¬ÂÂ¤Ã­ÂÂ° Ã¬ÂÂ´Ã«Â²Â¤Ã­ÂÂ¸

				//******************************************************

				raycaster = new THREE.Raycaster();

				mouse = new THREE.Vector2();
				mouse.x = mouse.y = -1;

				let onMouseClick = function(e){
					//ÃªÂ·Â¸Ã«Â¦Â¼ Ã¬ÂÂ Ã­ÂÂÃ­ÂÂÃ¬ÂÂ Ã«ÂÂ Ã¬ÂÂ´Ã«Â²Â¤Ã­ÂÂ¸
					if (instructions.style.display == 'none') {
						event.preventDefault();
						if ( SELECTED ){
							console.log("SELECTED : ", SELECTED);
							console.log("event: ", e);
							window.open("<c:url value='/WebVR/exhb/artwork?artworkId=' />" + SELECTED.uuid); //Ã«ÂÂÃ¬Â¤ÂÃ¬ÂÂ Ã¬ÂÂÃ­ÂÂÃ­ÂÂÃ«Â©Â´Ã¬ÂÂ¼Ã«Â¡Â Ã¬ÂÂ´Ã«ÂÂÃ­ÂÂÃªÂ²Â~
							controls.unlock();
						}
					} 
				}

				//renderer Ã¬ÂÂ¤Ã¬Â ÂÃ¬ÂÂ´Ã«ÂÂ Ã¬ÂÂÃ«ÂÂÃ¬ÂÂ° Ã¬Â°Â½ Ã­ÂÂ¬ÃªÂ¸Â°Ã¬ÂÂ Ã«Â§ÂÃ¬Â¶ÂÃªÂ¸Â°
				renderer = new THREE.WebGLRenderer( { antialias: true } );
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( window.innerWidth, window.innerHeight );
				document.body.appendChild( renderer.domElement );
   				
				document.addEventListener( 'click', onMouseClick );
				window.addEventListener( 'resize', onWindowResize );

				requestAnimationFrame(render);

				//GLTF Ã«Â¡ÂÃ«ÂÂ
				const loader2 = new GLTFLoader();
       		    loader2.load(
                	// resource URL
                	'<c:url value='/resources/three_js/exhibition_test.gltf' />',

                	// called when the resource is loaded
                	function ( gltf ) {
                    	scene.add( gltf.scene );
                    	gltf.animations; // Array<THREE.AnimationClip>
                    	gltf.scene; // THREE.Group
                    	gltf.scenes; // Array<THREE.Group>
                    	gltf.cameras; // Array<THREE.Camera>
                    	gltf.asset; // Object
                	}
            	);


				//Ã¬ÂÂ´Ã«Â¯Â¸Ã¬Â§Â Ã­ÂÂÃ«Â¸Â
				const img_loader = new THREE.TextureLoader();

				const geometry0 = new THREE.BoxGeometry(40, 25, 1);
				img_loader.load(s3_url + "${artworkList[0].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry0, material);
					cube.position.x = 57; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = 28; //고정
					cube.uuid = "${artworkList[0].artworkId}";
					scene.add(cube);
				});
				const geometry1 = new THREE.BoxGeometry(30, 20, 1);
				img_loader.load(s3_url + "${artworkList[1].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry1, material);
					cube.position.x = -55; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = 97; //고정
					cube.uuid = "${artworkList[1].artworkId}";
					scene.add(cube);
				});
				const geometry2 = new THREE.BoxGeometry(32, 23, 1);
				img_loader.load(s3_url + "${artworkList[2].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry2, material);
					cube.position.x = 0; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = 97; //고정
					cube.uuid = "${artworkList[2].artworkId}";
					scene.add(cube);
				});
				const geometry3 = new THREE.BoxGeometry(58, 39, 1);
				img_loader.load(s3_url + "${artworkList[3].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry3, material);
					cube.position.x = -97; //고정
					cube.position.y = 35; //세로로 이동(높이 조정)
					cube.position.z = 40; //가로로 이동
                    cube.rotation.y = Math.PI / 2;
					cube.uuid = "${artworkList[3].artworkId}";
					scene.add(cube);
				});
				const geometry4 = new THREE.BoxGeometry(34, 27, 1);
				img_loader.load(s3_url + "${artworkList[4].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry4, material);
					cube.position.x = -59; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = -22; //고정
					cube.uuid = "${artworkList[4].artworkId}";
					scene.add(cube);
				});
				const geometry5 = new THREE.BoxGeometry(36, 24, 1);
				img_loader.load(s3_url + "${artworkList[5].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry5, material);
					cube.position.x = 57; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = 22; //고정
					cube.uuid = "${artworkList[5].artworkId}";
					scene.add(cube);
				});
				const geometry6 = new THREE.BoxGeometry(60, 50, 1);
				img_loader.load(s3_url + "${artworkList[6].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry6, material);
					cube.position.x = 97; //고정
					cube.position.y = 35; //세로로 이동(높이 조정)
					cube.position.z = -40; //가로로 이동
                    cube.rotation.y = Math.PI / 2;
					cube.uuid = "${artworkList[6].artworkId}";
					scene.add(cube);
				});
				const geometry7 = new THREE.BoxGeometry(30, 30, 1);
				img_loader.load(s3_url + "${artworkList[7].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry7, material);
					cube.position.x = 60; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = -97; //고정
					cube.uuid = "${artworkList[7].artworkId}";
					scene.add(cube);
				});
				const geometry8 = new THREE.BoxGeometry(32, 23, 1);
				img_loader.load(s3_url + "${artworkList[8].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry8, material);
					cube.position.x = 0; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = -97; //고정
					cube.uuid = "${artworkList[8].artworkId}";
					scene.add(cube);
				});
				const geometry9 = new THREE.BoxGeometry(30, 20, 1);
				img_loader.load(s3_url + "${artworkList[9].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry9, material);
					cube.position.x = -55; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = -97; //고정
					cube.uuid = "${artworkList[9].artworkId}";
					scene.add(cube);
				});
				const geometry10 = new THREE.BoxGeometry(30, 20, 1);
				img_loader.load(s3_url + "${artworkList[10].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry10, material);
					cube.position.x = -97; //고정
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = -62; //가로로 이동
                    cube.rotation.y = Math.PI / 2;
					cube.uuid = "${artworkList[10].artworkId}";
					scene.add(cube);
				});
				const geometry11 = new THREE.BoxGeometry(40, 25, 1);
				img_loader.load(s3_url + "${artworkList[11].artworkAddress}", (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry11, material);
					cube.position.x = -57; //가로로 이동
					cube.position.y = 30; //세로로 이동(높이 조정)
					cube.position.z = -28; //고정
					cube.uuid = "${artworkList[11].artworkId}";
					scene.add(cube);
				});

			}

			function onWindowResize() {

				camera.aspect = window.innerWidth / window.innerHeight;
				camera.updateProjectionMatrix();

				renderer.setSize( window.innerWidth, window.innerHeight );

			}

			// function getCamera() {
			// 	var aspectRatio = window.innerWidth / window.innerHeight;
			// 	var camera = new THREE.PerspectiveCamera(75, aspectRatio, 0.1, 100000);
			// 	camera.position.set(0, 1, -6000);
			// 	return camera;
			// }
			
			function resizeRendererToDisplaySize(renderer) {
				const canvas = renderer.domElement;
				const width = canvas.clientWidth;
				const height = canvas.clientHeight;
				const needResize = canvas.width !== width || canvas.height !== height;
				if (needResize) {
				renderer.setSize(width, height, false);
				}
				return needResize;
			}

			function animate() {

				requestAnimationFrame( animate );

				const time = performance.now();

				if ( controls.isLocked === true ) {

					raycaster.ray.origin.copy( controls.getObject().position );
					raycaster.ray.origin.y -= 10;

					const intersections = raycaster.intersectObjects( objects );

					const onObject = intersections.length > 0;

					const delta = ( time - prevTime ) / 1000;

					velocity.x -= velocity.x * 10.0 * delta;
					velocity.z -= velocity.z * 10.0 * delta;

					velocity.y -= 9.8 * 100.0 * delta; // 100.0 = mass

					direction.z = Number( moveForward ) - Number( moveBackward );
					direction.x = Number( moveRight ) - Number( moveLeft );
					direction.normalize(); // this ensures consistent movements in all directions

					if ( moveForward || moveBackward ) velocity.z -= direction.z * 400.0 * delta;
					if ( moveLeft || moveRight ) velocity.x -= direction.x * 400.0 * delta;

					if ( onObject === true ) {

						velocity.y = Math.max( 0, velocity.y );

					}

					controls.moveRight( - velocity.x * delta );
					controls.moveForward( - velocity.z * delta );

					controls.getObject().position.y += ( velocity.y * delta ); // new behavior

					if ( controls.getObject().position.y < 30 ) {

						velocity.y = 0;
						controls.getObject().position.y = 30;

					}

				}

				prevTime = time;

				// renderer.render( scene, camera );
			}

			function render(time) {
				time *= 0.001;

				if (resizeRendererToDisplaySize(renderer)) {
					const canvas = renderer.domElement;
					camera.aspect = canvas.clientWidth / canvas.clientHeight;
					camera.updateProjectionMatrix();
				}

				//Ã¬ÂÂ¬ÃªÂ¸Â°
                raycaster.setFromCamera( camera.getWorldDirection( cameraDirection ), camera );

				//Ã«Â ÂÃ¬ÂÂ´Ã¬ÂºÂÃ¬ÂÂ¤Ã­ÂÂ° Ã«Â³Â´Ã¬ÂÂ´Ã«ÂÂ Ã¬Â½ÂÃ«ÂÂ (Ã­ÂÂÃ¬ÂÂ¸Ã¬ÂÂ©) 
				//scene.add(new THREE.ArrowHelper(raycaster.ray.direction, raycaster.ray.origin, 300, 0xff0000) );

				let intersects = raycaster.intersectObjects(scene.children);
				// intersects.forEach(obj=>obj.object.material.color.set(0x00ff00));

				if ( intersects.length > 0 ) {
					if ( SELECTED != intersects[ 0 ].object ) {
						// if ( SELECTED ) SELECTED.material.emissive.setHex( SELECTED.currentHex );
						SELECTED = intersects[ 0 ].object;
						//console.log("SELECTED : ", SELECTED);
						SELECTED.currentHex = SELECTED.material.emissive.getHex();
						// SELECTED.material.emissive.setHex( 0xff0000 );
						blocker.style.cursor = 'pointer';
					}
				} else {
					if ( SELECTED ) {
						// SELECTED.material.emissive.setHex( SELECTED.currentHex );
						SELECTED = null;
						blocker.style.cursor = 'auto';
					}
				}

				renderer.render(scene, camera);

				requestAnimationFrame(render); 
			}
		</script>
	<div id="blocker">
		<tr>
			<td width=70%><audio autoplay controls>
					<source src="https://webvrbucket.s3.ap-northeast-2.amazonaws.com/bgm/bensound-pianomoment.mp3"
						type="audio/mpeg" />
					Your browser does not support the audio tag.
				</audio></td>
			<td><a
				href="<c:url value='/WebVR/exhb/guestbook'>
                            <c:param name='exhibitionId' value='${exhibitionId}' />
                        </c:url>">
					<button type="button" class="btn">방명록</button>
			</a></td>
		</tr>
		<div id="instructions">
			<p style="font-size: 36px">Click to play</p>
			<p>
				Move: WASD<br /> Look: MOUSE
			</p>
		</div>
	</div>

</body>
</html>