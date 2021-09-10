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

			var imgUrl = "../resources/img/7.png";

			init();
			animate();

			function init() {
				//Ã¬Â¹Â´Ã«Â©ÂÃ«ÂÂ¼ + Ã¬ÂÂ¬ + ÃªÂ´ÂÃ¬ÂÂ Ã¬Â´ÂÃªÂ¸Â° Ã¬ÂÂ¤Ã¬Â Â
				camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 1, 1000 );
				camera.position.x = 50;
				camera.position.y = 30;
				camera.position.z = 50;
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
							window.open("http://www.naver.com"); //Ã«ÂÂÃ¬Â¤ÂÃ¬ÂÂ Ã¬ÂÂÃ­ÂÂÃ­ÂÂÃ«Â©Â´Ã¬ÂÂ¼Ã«Â¡Â Ã¬ÂÂ´Ã«ÂÂÃ­ÂÂÃªÂ²Â~
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
                	'<c:url value='/resources/three_js/exhibition01.gltf' />',

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

				//Ã¬ÂÂ´Ã«Â¯Â¸Ã¬Â§Â Ã­ÂÂÃ«Â¸Â
				const geometry = new THREE.BoxGeometry(20, 20, 1);
				// const cubes = [];  // just an array we can use to rotate the cubes
				const loader = new THREE.TextureLoader();
				loader.load(imgUrl, (texture) => {
					const material = new THREE.MeshLambertMaterial({
					map: texture,
					});
					const cube = new THREE.Mesh(geometry, material);
					cube.position.x = 0;
					cube.position.y = 30;
					cube.position.z = -70;
					scene.add(cube);
					// cubes.push(cube);  // add to our list of cubes to rotate
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
						console.log("SELECTED : ", SELECTED);
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
		<div id="instructions">
			<p style="font-size: 36px">Click to play</p>
			<p>
				Move: WASD<br /> Look: MOUSE
			</p>
		</div>
	</div>

</body>
</html>