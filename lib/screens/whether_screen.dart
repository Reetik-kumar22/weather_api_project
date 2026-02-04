import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:working_with_api/providers/weather_provider.dart';
import 'package:working_with_api/services/weather_state.dart';

class WhetherScreen extends ConsumerStatefulWidget {
  const WhetherScreen({super.key});

  @override
  ConsumerState<WhetherScreen> createState() => _WhetherScreenState();
}

class _WhetherScreenState extends ConsumerState<WhetherScreen> {
  final TextEditingController cityEditingController = TextEditingController();


  void _fetchWeather() {
    ref.read(weatherProvider.notifier).getWeather(cityEditingController.text);
  }

  String formatTemperature(double temp){
    return '${temp.round()}°C';
  }

  @override
  Widget build(BuildContext context) {
    final WeatherState weatherState = ref.watch(weatherProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final bool isTablet = screenWidth > 600;
    final bool isDesktop = screenWidth > 1200;

    //responsive spacing
    final horizontalPadding = isDesktop ? 40.0 : (isTablet ? 24.0 : 16.0);
    final verticalPadding = isDesktop ? 24.0 : (isTablet ? 20.0 : 16.0);

    return Scaffold(
      backgroundColor: Colors.blue[50],
     appBar: AppBar(
       title: Center(
         child: Text("Weather App",
           style: TextStyle(fontSize: isDesktop ? 28:(isTablet ? 26:24),
               fontWeight: FontWeight.bold),
         ),
       ),
       backgroundColor: Colors.blue[600],
       foregroundColor: Colors.white,
       elevation: 4,
       //responsive appbar height
       toolbarHeight: isDesktop ? 70:(isTablet ? 65:56),
     ),

      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isDesktop ? 1200: double.infinity),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isDesktop ? 24:(isTablet ? 20:16),),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(isDesktop ? 16:12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter City Name",
                        style: TextStyle(fontSize: isDesktop ? 18:(isTablet ? 17:16),
                            fontWeight: FontWeight.w600,color: Colors.blue[800]),
                      ),

                      SizedBox(height: 20,width: 16,),

                      TextField(
                        controller: cityEditingController,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),
                        decoration: InputDecoration(
                            labelText: "e.g., Delhi ,Mumbai, London",
                            labelStyle: TextStyle(fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.blue[600]!,
                                  style: BorderStyle.solid,
                                width: 3,
                              )
                            ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.blue[600]!,
                                style: BorderStyle.solid,
                                width: 3,
                              ),
                          ),
                          prefixIcon: Icon(Icons.search,size: 30,color: Colors.blue[600],),
                        ),
                      ),

                      SizedBox(height: 18,width: 16,),

                      weatherState.isLoading? CircularProgressIndicator()
                      : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: _fetchWeather,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[600],
                                foregroundColor: Colors.white),
                            child: Text("Get Weather",style: TextStyle(fontSize: 18),),),
                      ),
                       // temp
                     if(weatherState.weather != null)
                      Text("reps:  ${weatherState.weather!.condition.description}"),
                    ],
                  ),
                ),

                // weather data or error massage
                if(weatherState.errorMessage.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red[300]!),
                    ),
                    child: Text(weatherState.errorMessage),
                  ),

                if(weatherState.weather != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blue[600]!, Colors.blue[800]!],
                      begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ]
                    ),
                    child: Column(
                      children: [
                          Text('${weatherState.weather! .cityName}, ${weatherState.weather! .countryName}',
                            style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),
                          ),

                        SizedBox(height: 8,),

                        Text(weatherState.weather! .condition.description,
                          style: TextStyle(fontSize: 30,color: Colors.white.withOpacity(0.9),
                          ),
                        ),

                        SizedBox(height: 20,),

                        Text(formatTemperature(weatherState.weather! .main.temperature),
                          style: TextStyle(fontSize: 55,color: Colors.white,fontWeight: FontWeight.w300
                          ),
                        ),

                        SizedBox(height: 8,),

                        Text('Feels like : ${weatherState.weather! .main.feelsLike}',
                          style: TextStyle(fontSize: 24,color: Colors.white.withOpacity(0.9),
                          ),
                        ),

                      ],
                    ),
                  ),

                // Weather Details grid
                if(weatherState.weather != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        )
                      ]
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Weather Details",
                          style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.blue[800]),
                        ),

                        SizedBox(height: verticalPadding,),

                        LayoutBuilder(
                          builder: (context,constraints) {
                            // determine number of column based on available width
                            int crossAxisCount;
                            double childAspectRatio;

                            if(constraints.maxWidth > 800){
                              //Desktop
                              crossAxisCount = 3;
                              childAspectRatio = 1.3;
                            }else if(constraints.maxWidth > 400){
                              //Tablet
                              crossAxisCount = 2;
                              childAspectRatio = 1.3;
                            }else{
                              //Mobile
                              crossAxisCount =1 ;
                              childAspectRatio = 3.0;
                            }

                            return GridView.count(
                              shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: childAspectRatio,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              children: [
                                _buildDetailCard(
                                  icon: Icons.thermostat,
                                  title: 'Main Temp',
                                  value:formatTemperature(
                                      weatherState.weather!.main.tempMin,
                                  ),
                                  color:Colors.blue[600]!,
                                ),

                                _buildDetailCard(
                                  icon: Icons.thermostat,
                                  title: 'Max Temp',
                                  value: formatTemperature(
                                    weatherState.weather!.main.tempMax,
                                  ),
                                  color: Colors.orange[600]!,
                                ),

                                _buildDetailCard(
                                  icon: Icons.water_drop,
                                  title: 'Humidity',
                                  value: '${weatherState.weather!.main.humidity}',
                                  color: Colors.cyan[600]!,
                                ),

                                _buildDetailCard(
                                  icon: Icons.speed,
                                  title: 'Pressure',
                                  value: '${weatherState.weather!.main.pressure}%',
                                  color: Colors.purple[600]!,
                                ),

                                _buildDetailCard(
                                  icon: Icons.cloud,
                                  title: 'Condition',
                                  value: weatherState.weather!.condition.main,
                                    color: Colors.green[600]!,
                                ),

                                _buildDetailCard(
                                  icon: Icons.favorite,
                                  title: 'Feels Like',
                                  value: formatTemperature(
                                    weatherState.weather!.main.feelsLike,
                                  ),
                                  color: Colors.pink[600]!,
                                ),
                              ],

                            );
                          }
                        )
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
}) {
    return Container(
       padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: color, size: 35,),

          SizedBox(height: 2,),

          Text(
            title,style: TextStyle(fontSize: 18,color: Colors.grey[600],fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 2,),

          Text(value,
            style: TextStyle(fontSize: 17,color: color,fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
