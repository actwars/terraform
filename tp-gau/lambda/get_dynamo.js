import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  ScanCommand,
  PutCommand,
  GetCommand,
} from "@aws-sdk/lib-dynamodb";

const new_visit = Date.now();

const one_day = 86400000

const old_day = parseInt(new_visit) - parseInt(one_day)

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "count_visit";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  let old_day
  const headers = {
    "Content-Type": "application/json",
  };

  try {
    switch (event.routeKey) {
      case "GET /count":
        body = await dynamo.send(
          new ScanCommand({ TableName: tableName })
        );
//        body = body.Count;
        break;
      case "GET /add_count":
//        let requestJSON = JSON.parse(event.body);
        await dynamo.send(
          new PutCommand({
            TableName: tableName,
            Item: {
              time_stamp: new_visit,
            },
          })
        );
        body = `Put item ${new_visit}`;
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    old_day,
    headers,
  };
};
