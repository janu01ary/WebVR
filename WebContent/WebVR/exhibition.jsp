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

				const light = new THREE.HemisphereLight( 0xeeeeff, 0x777788, 1 );
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

				function Vector(x, y, z) {
					this.x = x;
					this.y = y;
					this.z = z;
				}

				//작품 이미지 큐브를 만들어 배치
				//파라미터 id: artwork의 id / imgUrl: artwork의 이미지 url / size: artwork의 크기(Vector) / position: artwork의 위치 / rotation: artwork 회전 여부(T/F) 
				function makeImgCube(id, imgUrl, size, position, rotation) {
					const geometry = new THREE.BoxGeometry(size.x, size.y, size.z);
					img_loader.load(s3_url + imgUrl, (texture) => {
						const material = new THREE.MeshLambertMaterial({
							map: texture,
						});
						const cube = new THREE.Mesh(geometry, material);
						cube.position.x = position.x; //가로로 이동
						cube.position.y = position.y; //세로로 이동(높이 조정)
						cube.position.z = position.z; //고정
						cube.uuid = id;
						if (rotation) {
                    		cube.rotation.y = Math.PI / 2;
						}
						scene.add(cube);
					});
				}

				//작품의 위치 리스트
				const positionList = [
					new Vector(57, 30, 28),
					new Vector(-55, 30, 97),
					new Vector(0, 30, 97),
					new Vector(-97, 35, 40),
					new Vector(-59, 30, -22),
					new Vector(57, 30, 22),
					new Vector(97, 35, -40),
					new Vector(60, 30, -97),
					new Vector(0, 30, -97),
					new Vector(-60, 30, -97),
					new Vector(-97, 30, -62),
					new Vector(-57, 30, -28),
				];
					
				//작품들을 모두 장면에 배치
				<c:forEach var="artwork" items="${artworkList}" varStatus="status">
					makeImgCube(
						"${artwork.artworkId}", 
						"${artwork.artworkAddress}", 
						//new Vector(40, 25, 1), 
						//positionList[${status.index}], 
						<c:choose>
							<c:when test="${status.index eq 3 || status.index eq 6}"> 
								<%--new Vector(${artwork.width} / 20, ${artwork.height} / 20, 1),--%>
								new Vector(60, 45.25, 1),
								positionList[${status.index}], 
								true
							</c:when>
							<c:when test="${status.index eq 10}"> 
								<%--new Vector(${artwork.width} / 30, ${artwork.height} / 30, 1),--%>
								new Vector(40, 30, 1),
								positionList[${status.index}], 
								true
							</c:when>
							<c:otherwise>
								<%--new Vector(${artwork.width} / 30, ${artwork.height} / 30, 1),--%>
								new Vector(40, 30, 1),
								positionList[${status.index}], 
								false
							</c:otherwise>
						</c:choose>
					);
				</c:forEach>

				/*
				makeImgCube(${artworkList[0].artworkId}, "${artworkList[0].artworkAddress}", new Vector(40, 25, 1), new Vector(57, 30, 28), false);
				makeImgCube(${artworkList[1].artworkId}, "${artworkList[1].artworkAddress}", new Vector(30, 20, 1), new Vector(-55, 30, 97), false);
				makeImgCube(${artworkList[2].artworkId}, "${artworkList[2].artworkAddress}", new Vector(32, 23, 1), new Vector(0, 30, 97), false);
				makeImgCube(${artworkList[3].artworkId}, "${artworkList[3].artworkAddress}", new Vector(58, 39, 1), new Vector(-97, 35, 40), true);
				makeImgCube(${artworkList[4].artworkId}, "${artworkList[4].artworkAddress}", new Vector(34, 27, 1), new Vector(-59, 30, -22), false);
				makeImgCube(${artworkList[5].artworkId}, "${artworkList[5].artworkAddress}", new Vector(36, 24, 1), new Vector(57, 30, 22), false);
				makeImgCube(${artworkList[6].artworkId}, "${artworkList[6].artworkAddress}", new Vector(60, 50, 1), new Vector(97, 35, -40), true);
				makeImgCube(${artworkList[7].artworkId}, "${artworkList[7].artworkAddress}", new Vector(30, 30, 1), new Vector(60, 30, -97), false);
				makeImgCube(${artworkList[8].artworkId}, "${artworkList[8].artworkAddress}", new Vector(32, 23, 1), new Vector(0, 30, -97), false);
				makeImgCube(${artworkList[9].artworkId}, "${artworkList[9].artworkAddress}", new Vector(30, 20, 1), new Vector(-55, 30, -97), false);
				makeImgCube(${artworkList[10].artworkId}, "${artworkList[10].artworkAddress}", new Vector(30, 20, 1), new Vector(-97, 30, -62), false);
				makeImgCube(${artworkList[11].artworkId}, "${artworkList[11].artworkAddress}", new Vector(40, 25, 1), new Vector(-57, 30, -28), false);

				const light3 = new THREE.SpotLight(0xffffff, 10);
				light3.target.position.set(-97, 35, 40);
				light3.position.set(-50, 90, 40);
				light3.distance = 200;
				light3.angle = 0.5;
				scene.add(light3);
    			scene.add(light3.target);
*/
				//spotlight를 만들어 장면에 배치
				function makeSpotLight(start, target) {
					const light = new THREE.SpotLight(0xffffff, 1);
					light.target.position.set(target.x, target.y, target.z);
					light.position.set(start.x, start.y, start.z);
					light.distance = 200;
					light.angle = 0.3;
					scene.add(light);
    				scene.add(light.target);
				}

				//spotlight 12개를 만들어 배치
				makeSpotLight(new Vector(57, 95, 58), positionList[0]); //0
				makeSpotLight(new Vector(-55, 95, 87), positionList[1]); //1
				makeSpotLight(new Vector(0, 95, 87), positionList[2]); //2
				makeSpotLight(new Vector(-67, 95, 40), positionList[3]); //3
				makeSpotLight(new Vector(-59, 95, 18), positionList[4]); //4
				makeSpotLight(new Vector(57, 95, -18), positionList[5]); //5
				makeSpotLight(new Vector(67, 95, -40), positionList[6]); //6
				makeSpotLight(new Vector(60, 95, -67), positionList[7]); //7
				makeSpotLight(new Vector(0, 95, -67), positionList[8]); //8
				makeSpotLight(new Vector(-55, 95, -67), positionList[9]); //9
				makeSpotLight(new Vector(-67, 95, -62), positionList[10]); //10
				makeSpotLight(new Vector(-57, 95, -58), positionList[11]); //11
	
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
		<tr width=100%>
			<td width=70%><audio autoplay controls>
					<source src="../resources/audio/bensound-ukulele.mp3"
						type="audio/mpeg" />
					Your browser does not support the audio tag.
				</audio></td>
			<td width=30%><a
				href="<c:url value='/WebVR/exhb/guestbook'>
                            <c:param name='exhibitionId' value='${exhibitionId}' />
                        </c:url>"
				button type="button" class="btn btn-default">방명록
					</button>
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